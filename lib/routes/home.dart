import 'package:flutter/material.dart';

import '../widgets/containers/home/last_transactions_list.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double appBarHeightRatio = 0.065;
    double horizontalPaddingRatio = 0.075;
    Size size = MediaQuery.of(context).size;
    SizedBox largeSpacer = SizedBox(
      height: size.height * 0.05,
    );
    double myCardHeightRatio = 0.25;
    double actionsHeightRatio = 0.1;
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * horizontalPaddingRatio),
            child: const LastTransactionsListContainer(
              title: "Expenses",
            )),
      ],
    );
  }
}
