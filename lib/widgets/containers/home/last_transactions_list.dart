import 'package:credit_card/models/transactions.dart';
import 'package:credit_card/util/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/expenses.dart';
import '../../../theme.dart';
import 'last_transaction_tab.dart';

class LastTransactionsListContainer extends StatelessWidget {
  final String title;
  const LastTransactionsListContainer({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double tabheight = size.height * 0.08;
    SizedBox space = SizedBox(height: size.height * 0.025);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.25,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              title,
              style: GoogleFonts.sora(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        space,
        FutureBuilder<List<Expenses>>(
          future: DatabaseService.getExpenses(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data!
                    .map((expense) => Column(
                          children: [
                            LastTransactionTabContainer(
                                height: tabheight, expenses: expense),
                            space
                          ],
                        ))
                    .toList(),
              );
            }
            return const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(color: MyTheme.darkBlue));
          },
        )
      ],
    );
  }
}
