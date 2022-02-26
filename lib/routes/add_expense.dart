import 'package:credit_card/state/add_expense/due.dart';
import 'package:credit_card/state/add_expense/summary.dart';
import 'package:credit_card/state/add_expense/title.dart';
import 'package:credit_card/state/add_expense/to.dart';
import 'package:credit_card/theme.dart';
import 'package:credit_card/widgets/containers/common/checkbox.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../state/add_expense/amount.dart';
import '../widgets/containers/common/button.dart';
import '../widgets/containers/common/textfield.dart';
import '../widgets/containers/login/credit_card_3d.dart';
import 'package:intl/intl.dart';

class AddExpenseRoute extends StatefulWidget {
  const AddExpenseRoute({Key? key}) : super(key: key);

  @override
  _AddExpenseRouteState createState() => _AddExpenseRouteState();
}

class _AddExpenseRouteState extends State<AddExpenseRoute> {
  final _formKey = GlobalKey<FormState>();

  late AddExpenseTitle addTitleProvider;
  late AddExpenseAmount addAmountProvider;
  late AddExpenseSummary addExpenseSummary;
  late AddExpenseTo addExpenseTo;
  late AddDebtDue addDebtDue;
  bool isDebt = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        addTitleProvider = Provider.of<AddExpenseTitle>(context, listen: false);
        addAmountProvider =
            Provider.of<AddExpenseAmount>(context, listen: false);
        addExpenseSummary =
            Provider.of<AddExpenseSummary>(context, listen: false);
        addExpenseTo = Provider.of<AddExpenseTo>(context, listen: false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    addDebtDue = Provider.of<AddDebtDue>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double creditCard3dHeightRatio = 0.2;
    double titleheightRatio = 0.05;
    double largeSpacerRatio = 0.1;
    double formHeightRatio = 0.375;
    double smallSpacerRatio = 0.035;
    double textfieldHeight = size.height * 0.075;
    double textfieldWidth = size.width * 0.8;
    return Column(
      children: [
        CreditCard3DContainer(height: size.height * creditCard3dHeightRatio),
        SizedBox(
          height: size.height * largeSpacerRatio,
        ),
        SizedBox(
          height: size.height * titleheightRatio,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
              "Add Expense",
              style: GoogleFonts.sora(
                  color: const Color.fromRGBO(73, 135, 185, 1),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: size.height * smallSpacerRatio,
        ),
        Form(
          key: _formKey,
          child: Column(children: [
            TextfieldContainer(
                height: textfieldHeight,
                width: textfieldWidth,
                hintText: 'title',
                providerUpdater: (title) => addTitleProvider.setTitle(title)),
            SizedBox(
              height: size.height * smallSpacerRatio,
            ),
            TextfieldContainer(
                height: textfieldHeight,
                width: textfieldWidth,
                hintText: 'amount',
                regexPattern: '^[0-9]+(\\.[0-9]+)?\$',
                matchFailedMessage: 'enter numbers please',
                providerUpdater: (amount) =>
                    addAmountProvider.setAmount(amount)),
            SizedBox(
              height: size.height * smallSpacerRatio,
            ),
            TextfieldContainer(
                height: textfieldHeight,
                width: textfieldWidth,
                hintText: 'summary',
                isTextArea: true,
                providerUpdater: (summary) =>
                    addExpenseSummary.setSummary(summary)),
            SizedBox(
              height: size.height * smallSpacerRatio * 0.5,
            ),
            SizedBox(
              width: textfieldWidth,
              child: Row(children: [
                isDebt
                    ? InkWell(
                        onTap: () => DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(2100, 1, 1), onChanged: (date) {
                          addDebtDue
                              .setDate(DateFormat('yyyy-MM-dd').format(date));
                        }, onConfirm: (date) {
                          addDebtDue
                              .setDate(DateFormat('yyyy-MM-dd').format(date));
                        }, currentTime: DateTime.now(), locale: LocaleType.en),
                        child: SizedBox(
                            height: size.width * 0.05,
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  addDebtDue.due ?? 'Select Due Date',
                                  style: GoogleFonts.sora(
                                      color: MyTheme.darkBlue,
                                      decoration: TextDecoration.underline),
                                ))),
                      )
                    : Container(),
                const Spacer(
                  flex: 10,
                ),
                SizedBox(
                    height: size.width * 0.05,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "I'm Debting",
                          style: GoogleFonts.sora(color: MyTheme.darkBlue),
                        ))),
                const Spacer(),
                CustomCheckbox(
                  size: size.width * 0.075,
                  check: (value) => setState(() {
                    isDebt = value!;
                  }),
                  isChecked: isDebt,
                ),
              ]),
            ),
            SizedBox(
              height: size.height * smallSpacerRatio,
            ),
            TextfieldContainer(
                height: textfieldHeight,
                width: textfieldWidth,
                hintText: 'to',
                providerUpdater: (to) => addExpenseTo.setTo(to)),
            SizedBox(
              height: size.height * smallSpacerRatio,
            ),
            CustomButton(
                width: textfieldWidth,
                height: textfieldHeight * 0.9,
                formKey: _formKey,
                description: 'Add',
                onPressed: addExpense)
          ]),
        ),
      ],
    );
  }

  addExpense() {
    if (_formKey.currentState!.validate()) {}
  }
}
