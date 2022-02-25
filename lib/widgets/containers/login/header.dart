import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormHeader extends StatelessWidget {
  final double height;
  const FormHeader({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: height,
        width: size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(
              flex: 2,
            ),
            SizedBox(
              height: height * 0.5,
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
            const Spacer(
              flex: 6,
            ),
            SizedBox(
              height: height * 0.4,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  "Enter your username and password",
                  style: GoogleFonts.sora(color: Colors.black, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
