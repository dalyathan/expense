import 'package:credit_card/widgets/containers/login/credit_card_3d.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/containers/login/form.dart';
import '../widgets/containers/login/header.dart';
import '../widgets/containers/login/no_account.dart';
import '../widgets/containers/signin/signin_options.dart';

class SigninRoute extends StatelessWidget {
  const SigninRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double creditCard3dHeightRatio = 0.2;
    double titleheightRatio = 0.075;
    double largeSpacerRatio = 0.125;
    double formHeightRatio = 0.375;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CreditCard3DContainer(height: size.height * creditCard3dHeightRatio),
          SizedBox(
            height: size.height * largeSpacerRatio,
          ),
          Center(
            child: SizedBox(
              height: size.height * 0.05,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  "Expense App",
                  style: GoogleFonts.sora(
                      color: const Color.fromRGBO(73, 135, 185, 1),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: SigninOptions(
              width: size.width * 0.8,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Center(
            child: NoAccountContainer(
              height: size.height * 0.0765,
            ),
          ),
        ],
      )),
    );
  }
}
