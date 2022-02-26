import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final double size;
  final bool isChecked;
  final void Function(bool?) check;
  const CustomCheckbox(
      {Key? key,
      required this.size,
      required this.isChecked,
      required this.check})
      : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    double containerBorderRadius = widget.size * 0.15;
    return Container(
        height: widget.size,
        width: widget.size,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(230, 230, 230, 1),
              Color.fromRGBO(240, 240, 240, 1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.4],
            tileMode: TileMode.clamp,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(containerBorderRadius)),
          ),
        ),
        child: Center(
            child: SizedBox(
                width: widget.size,
                height: widget.size,
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.transparent),
                  child: Checkbox(
                    value: widget.isChecked,
                    onChanged: widget.check,
                  ),
                ))));
  }
}
