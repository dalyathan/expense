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
    double tabheight = size.height * 0.075;
    SizedBox space = SizedBox(height: size.height * 0.05);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
        FutureBuilder<List<Expenses>>(
          future: DatabaseService.getExpenses(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
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
              } else {
                return Center(
                  child: SizedBox(
                    width: size.width * 0.2,
                    child: const FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text("No records to display")),
                  ),
                );
              }
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
