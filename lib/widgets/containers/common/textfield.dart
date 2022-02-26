import 'package:flutter/material.dart';

import '../../../theme.dart';

class TextfieldContainer extends StatefulWidget {
  final double height;
  final double width;
  final String hintText;
  final Function(String) providerUpdater;
  bool isPasswordField;
  bool isTextArea;
  String? regexPattern;
  String? matchFailedMessage;
  String? initialValue;
  TextfieldContainer(
      {Key? key,
      required this.height,
      required this.width,
      required this.hintText,
      required this.providerUpdater,
      this.isPasswordField = false,
      this.isTextArea = false,
      this.regexPattern,
      this.matchFailedMessage})
      : super(key: key);

  @override
  State<TextfieldContainer> createState() => _TextfieldContainerState();
}

class _TextfieldContainerState extends State<TextfieldContainer> {
  late bool hideText;

  @override
  void initState() {
    super.initState();
    hideText = widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    double textfieldBorderRadiusRatio = 0.3;
    double textfieldHeight =
        widget.isTextArea ? 2 * widget.height * 0.8 : widget.height * 0.8;
    double fieldBorderRadius = textfieldBorderRadiusRatio * textfieldHeight;
    double containerBorderRadius = textfieldHeight * textfieldBorderRadiusRatio;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: textfieldHeight,
          width: widget.width,
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
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: TextFormField(
              style: TextStyle(fontSize: widget.height * 0.3),
              obscureText: hideText,
              onChanged: (value) => widget.providerUpdater(value),
              maxLines: widget.isTextArea ? 10 : 1,
              initialValue: widget.initialValue ?? '',
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  contentPadding: EdgeInsets.only(
                    left: widget.width * 0.075,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(fieldBorderRadius),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(fieldBorderRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(fieldBorderRadius),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(fieldBorderRadius),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(fieldBorderRadius),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (widget.regexPattern != null &&
                    RegExp(widget.regexPattern!).hasMatch(value) == false) {
                  return widget.matchFailedMessage!;
                }
                widget.providerUpdater(value);
                return null;
              },
            ),
          ),
        ),
        Positioned(
          top: widget.height * 0.15,
          right: widget.width * 0.05,
          child: widget.isPasswordField
              ? InkResponse(
                  radius: widget.height * 0.4,
                  onTap: () => setState(() {
                    hideText = hideText ? false : true;
                  }),
                  child: Icon(
                    hideText ? Icons.lock_rounded : Icons.lock_open_rounded,
                    color: MyTheme.darkBlue,
                    size: widget.height * 0.4,
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}
