import 'package:credit_card/routes/signup.dart';
import 'package:credit_card/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoAccountContainer extends StatelessWidget {
  final double height;
  const NoAccountContainer({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Text(
            "You don't have an account yet?",
            style: GoogleFonts.sora(fontSize: 15),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupRoute()),
            ),
            child: Text(
              "create account",
              style: GoogleFonts.sora(
                  color: MyTheme.darkBlue,
                  fontSize: 17,
                  decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }
}
