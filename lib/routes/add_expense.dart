import 'package:credit_card/state/add_expense/due.dart';
import 'package:credit_card/state/add_expense/summary.dart';
import 'package:credit_card/state/add_expense/title.dart';
import 'package:credit_card/state/add_expense/to.dart';
import 'package:credit_card/theme.dart';
import 'package:credit_card/util/database_service.dart';
import 'package:credit_card/widgets/containers/common/checkbox.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';

import '../state/add_expense/amount.dart';
import '../widgets/containers/common/button.dart';
import '../widgets/containers/common/textfield.dart';
import '../widgets/containers/login/credit_card_3d.dart';

import 'contacts_list.dart';

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
  bool addingInProgress = false;
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    addDebtDue = Provider.of<AddDebtDue>(context, listen: true);
    addExpenseTo = Provider.of<AddExpenseTo>(context, listen: true);
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
                          addDebtDue.setDate(date);
                        }, onConfirm: (date) {
                          addDebtDue.setDate(date);
                        }, currentTime: DateTime.now(), locale: LocaleType.en),
                        child: SizedBox(
                            height: size.width * 0.05,
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Consumer<AddDebtDue>(
                                  builder: (context, value, child) => Text(
                                    value.due != null
                                        ? 'due ${DateFormat('yyyy-MM-dd').format(value.due!)}'
                                        : 'Select Due Date',
                                    style: GoogleFonts.sora(
                                        color: MyTheme.darkBlue,
                                        decoration: TextDecoration.underline),
                                  ),
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
            SizedBox(
              width: textfieldWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: textfieldWidth * 0.075,
                      width: textfieldWidth * 0.6,
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Consumer<AddExpenseTo>(
                            builder: (_, to, __) => Text(
                              to.to != null
                                  ? 'Payed to ${to.to!.displayName}'
                                  : 'Select Who you\'re Paying ${isDebt ? '' : '(optional)'}',
                              style: GoogleFonts.sora(
                                color: MyTheme.darkBlue,
                              ),
                            ),
                          ))),
                  CustomButton(
                      width: textfieldWidth * 0.3,
                      height: textfieldHeight * 0.6,
                      description: 'Select',
                      onPressed: selectContact),
                ],
              ),
            ),
            SizedBox(
              height: size.height * smallSpacerRatio,
            ),
            addingInProgress
                ? SizedBox(
                    width: textfieldHeight * 0.9,
                    height: textfieldHeight * 0.9,
                    child: const CircularProgressIndicator(
                        color: MyTheme.darkBlue))
                : CustomButton(
                    width: textfieldWidth,
                    height: textfieldHeight * 0.9,
                    description: 'Add',
                    onPressed: insertToDb)
          ]),
        ),
      ],
    );
  }

  insertToDb() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showErrorMessage('Please connect to the internet and try again');
    } else {
      if (_formKey.currentState!.validate()) {
        if (isDebt) {
          insertDebt();
        } else {
          insertNormalExpense();
        }
      } else {}
    }
  }

  insertNormalExpense() {
    setState(() {
      addingInProgress = true;
    });
    DatabaseService.addExpense(
            addTitleProvider.title,
            addAmountProvider.amount,
            addExpenseSummary.summary,
            addExpenseTo.to != null ? addExpenseTo.to!.displayName! : '',
            context,
            getContactInfo(),
            null)
        .then((value) {
      setState(() {
        addingInProgress = false;
      });
      addExpenseTo.setTo(null);
      addDebtDue.setDate(null);
      showErrorMessage("Expense successfully added");
    });
  }

  insertDebt() {
    if (addDebtDue.due == null) {
      showErrorMessage('Please select due date');
    } else if (addExpenseTo.to == null) {
      showErrorMessage('Please select who you\'re debting.');
    } else {
      setState(() {
        addingInProgress = true;
      });
      DatabaseService.addExpense(
        addTitleProvider.title,
        addAmountProvider.amount,
        addExpenseSummary.summary,
        addExpenseTo.to != null ? addExpenseTo.to!.displayName! : '',
        context,
        getContactInfo(),
        addDebtDue.due!,
      ).then((value) {
        setState(() {
          addingInProgress = false;
        });
        addExpenseTo.setTo(null);
        addDebtDue.setDate(null);
        showErrorMessage("Debt successfully added");
      });
    }
  }

  String getContactInfo() {
    if (addExpenseTo.to == null) {
      return '';
    }
    Contact payee = addExpenseTo.to!;
    String payeeInfo = '';
    if (payee.phones != null && payee.phones!.isNotEmpty) {
      for (Item item in payee.phones!) {
        if (item.value != null) {
          return item.value!;
        }
      }
    }
    return '';
  }

  selectContact() async {
    var status = await Permission.contacts.status;
    if (status.isDenied) {
      if (await Permission.contacts.request().isGranted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactsList()),
        );
      } else {
        showErrorMessage("Contacts Access Denied");
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ContactsList()),
      );
    }
  }

  showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: MyTheme.darkBlue,
      content: Text(message, style: GoogleFonts.sora()),
    ));
  }
}
