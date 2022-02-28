import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OutIcon extends StatelessWidget {
  final double height;
  const OutIcon({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 109, 109, 1),
      ),
      child: Align(
        alignment: const Alignment(0, -0.75),
        child: Icon(FontAwesomeIcons.caretDown,
            size: height * 0.75, color: Colors.white),
      ),
    );
  }
}
