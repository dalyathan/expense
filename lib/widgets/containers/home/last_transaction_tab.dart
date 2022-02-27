import 'package:credit_card/models/expenses.dart';
import 'package:credit_card/theme.dart';
import 'package:credit_card/widgets/containers/common/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../models/transactions.dart';

class LastTransactionTabContainer extends StatelessWidget {
  final double height;
  final Expenses expenses;
  const LastTransactionTabContainer(
      {Key? key, required this.height, required this.expenses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double iconDiameter = height * 0.75;
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
    return SizedBox(
      height: height,
      child: ListTile(
        leading: Column(children: [
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
                  child: Text("\$${expenses.amount}",
                      style: GoogleFonts.sora(color: MyTheme.darkBlue))))
        ]),
        title: SizedBox(
          width: size.width * 0.05,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(expenses.to,
                style: GoogleFonts.sora(color: MyTheme.darkBlue)),
          ),
        ),
        subtitle:
            Text(expenses.summary, style: GoogleFonts.sora(color: Colors.grey)),
        isThreeLine: true,
        trailing: due != null
            ? Column(children: [
                Icon(
                  Icons.calendar_today,
                  color: iconColor,
                  size: height * 0.345,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                SizedBox(
                    width: size.width * 0.175,
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                            "Due ${isDebtDueToday ? 'Today' : DateFormat('yyyy-MM-dd').format(due)}",
                            style: GoogleFonts.sora(color: iconColor)))),
                SizedBox(
                  height: height * 0.05,
                ),
                SizedBox(
                    width: size.width * 0.165,
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text("Send Reminder?",
                            style: GoogleFonts.sora(color: iconColor)))),
              ])
            : const SizedBox(),
      ),
    );
  }
}
