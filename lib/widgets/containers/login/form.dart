import 'package:credit_card/state/password.dart';
import 'package:credit_card/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../screen.dart';
import '../../../state/email.dart';
import 'button.dart';
import 'textfield.dart';

class LoginFormContainer extends StatefulWidget {
  final double height;
  const LoginFormContainer({Key? key, required this.height}) : super(key: key);

  @override
  State<LoginFormContainer> createState() => _LoginFormContainerState();
}

class _LoginFormContainerState extends State<LoginFormContainer> {
  final _formKey = GlobalKey<FormState>();
  late Email emailProvider;
  late Password passwordProvider;
  bool invalidCredential = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      await Firebase.initializeApp();
      setState(() {
        emailProvider = Provider.of<Email>(context, listen: false);
        passwordProvider = Provider.of<Password>(context, listen: false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double textfieldHeight = 0.2 * widget.height;
    double textfieldWidth = size.width * 0.8;
    return SizedBox(
      height: widget.height,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextfieldContainer(
              height: textfieldHeight,
              width: textfieldWidth,
              providerUpdater: (value) => emailProvider.setUsername(value),
            ),
            const Spacer(
              flex: 2,
            ),
            TextfieldContainer(
              height: textfieldHeight,
              width: textfieldWidth,
              isPasswordField: true,
              providerUpdater: (value) => passwordProvider.setPassword(value),
            ),
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              width: textfieldWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: textfieldWidth * 0.4,
                    height: widget.height * 0.05,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: invalidCredential
                          ? FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "Invalid Credentials",
                                style: GoogleFonts.sora(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600),
                              ))
                          : Container(),
                    ),
                  ),
                  SizedBox(
                    height: widget.height * 0.05,
                    width: textfieldWidth * 0.4,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.sora(
                              decoration: TextDecoration.underline,
                              color: MyTheme.darkBlue,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(
              flex: 5,
            ),
            CustomButton(
              height: textfieldHeight * 0.9,
              width: textfieldWidth,
              formKey: _formKey,
              description: 'Login',
              onPressed: onLogin,
            )
          ],
        ),
      ),
    );
  }

  onLogin() async {
    if (_formKey.currentState!.validate()) {
      var email = emailProvider.email;
      var password = passwordProvider.password;
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          invalidCredential = true;
        });
      }
    }
  }
}
