import 'package:credit_card/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String description;
  final VoidCallback onPressed;

  CustomButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.description,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderRadiusRatio = 0.25;
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromRGBO(41, 62, 81, 1), MyTheme.darkBlue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.175],
          tileMode: TileMode.clamp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(height * borderRadiusRatio)),
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height * borderRadiusRatio),
              side: const BorderSide(
                color: Color.fromRGBO(41, 62, 81, 1),
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(description),
      ),
    );
  }
}
