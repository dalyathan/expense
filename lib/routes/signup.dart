import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/containers/login/credit_card_3d.dart';

class SignupRoute extends StatefulWidget {
  const SignupRoute({Key? key}) : super(key: key);

  @override
  _SignupRouteState createState() => _SignupRouteState();
}

class _SignupRouteState extends State<SignupRoute> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double creditCard3dHeightRatio = 0.2;
    double titleheightRatio = 0.05;
    double largeSpacerRatio = 0.125;
    double formHeightRatio = 0.375;
    return SafeArea(
      child: Scaffold(
          body: Column(
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
                "Signup",
                style: GoogleFonts.sora(
                    color: const Color.fromRGBO(73, 135, 185, 1),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: size.height * largeSpacerRatio,
          ),
        ],
      )),
    );
  }
}
