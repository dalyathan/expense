import 'package:credit_card/models/expenses.dart';
import 'package:credit_card/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LastTransactionTabContainer extends StatelessWidget {
  final double height;
  final Expenses expenses;
  const LastTransactionTabContainer(
      {Key? key, required this.height, required this.expenses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime? due = expenses.due;
    DateTime today = DateTime.now();
    bool isDebtDueToday = due != null &&
        due.year == today.year &&
        due.month == today.month &&
        due.day == today.day;
    bool isDebtPastDueDate = due != null &&
        due.year <= today.year &&
        due.month <= today.month &&
        due.day < today.day;
    late Color iconColor;
    if (isDebtDueToday) {
      iconColor = Colors.green;
    } else if (isDebtPastDueDate) {
      iconColor = Colors.red;
    } else {
      iconColor = MyTheme.darkBlue;
    }
    var f = NumberFormat("###,###.0#", "en_US");

    return SizedBox(
      height: height,
      child: ListTile(
        leading: SizedBox(
          width: size.width * 0.1,
          child: Column(children: [
            Icon(
              Icons.paid,
              color: MyTheme.darkBlue,
              size: height * 0.5,
            ),
            SizedBox(
              height: height * 0.1,
            ),
            SizedBox(
                width: size.width * 0.1,
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text("\$${f.format(double.parse(expenses.amount))}",
                        style: GoogleFonts.sora(color: MyTheme.darkBlue))))
          ]),
        ),
        title: Align(
          alignment: const Alignment(-1, 0),
          child: AutoSizeText(
              expenses.to.isNotEmpty ? expenses.to : expenses.title,
              maxLines: 2,
              style: GoogleFonts.sora(color: MyTheme.darkBlue)),
        ),
        subtitle: Align(
            alignment: Alignment.topLeft,
            child: AutoSizeText(expenses.summary,
                maxLines: 2, style: GoogleFonts.sora(color: Colors.grey))),
        isThreeLine: true,
        trailing: due != null
            ? InkWell(
                onTap: () => sendReminder(context, isDebtPastDueDate),
                child: Column(children: [
                  Icon(
                    Icons.calendar_today,
                    color: iconColor,
                    size: height * 0.35,
                  ),
                  SizedBox(
                    height: height * 0.075,
                  ),
                  SizedBox(
                      width: size.width * 0.17,
                      child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                              "${isDebtPastDueDate ? 'Was' : ''} due ${isDebtDueToday ? 'Today' : DateFormat('yyyy-MM-dd').format(due)}",
                              style: GoogleFonts.sora(color: iconColor)))),
                  SizedBox(
                    height: height * 0.075,
                  ),
                  SizedBox(
                      width: size.width * 0.15,
                      child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text("Send Reminder?",
                              style: GoogleFonts.sora(color: iconColor)))),
                ]),
              )
            : const SizedBox(),
      ),
    );
  }

  sendReminder(BuildContext context, bool isDebtPastDueDate) async {
    if (expenses.contactInfo.isNotEmpty) {
      await sendSMS(
          message:
              'hey ${expenses.to} how are you doing? just wanted let you know that your debt ${isDebtPastDueDate ? 'was' : 'is'} due ${DateFormat('yyyy-MM-dd').format(expenses.due!)}',
          recipients: [expenses.contactInfo]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: MyTheme.darkBlue,
        content: Text('No contact info available', style: GoogleFonts.sora()),
      ));
    }
  }
}
