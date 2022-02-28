import 'package:credit_card/state/total_expense/monthly.dart';
import 'package:credit_card/state/total_expense/weekly.dart';
import 'package:credit_card/widgets/containers/common/blue_gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'dollar.dart';

class TotalBalanceContainer extends StatelessWidget {
  final double height;
  const TotalBalanceContainer({Key? key, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var f = NumberFormat("###,###.0#", "en_US");
    return Stack(
      alignment: Alignment.center,
      children: [
        BlueGradientContainer(width: size.width, height: height),
        Column(
          children: [
            DollarContainer(
              radius: height * 0.2,
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Consumer<MonthlyExpense>(
              builder: (_, value, __) => Text(
                "You have spent a total of \$${f.format(double.parse(value.expense.toStringAsFixed(2)))} this month",
                style: GoogleFonts.sora(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Consumer<WeeklyExpense>(
              builder: (_, value, __) => Text(
                "and a total of \$${f.format(double.parse(value.expense.toStringAsFixed(2)))} this week",
                style: GoogleFonts.sora(
                  color: Colors.white,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
