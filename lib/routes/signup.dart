import 'package:credit_card/state/signup/first_name.dart';
import 'package:credit_card/state/signup/last_name.dart';
import 'package:credit_card/widgets/containers/common/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../state/login/email.dart';
import '../state/login/password.dart';
import '../widgets/containers/common/button.dart';
import '../widgets/containers/login/credit_card_3d.dart';

class SignupRoute extends StatefulWidget {
  const SignupRoute({Key? key}) : super(key: key);

  @override
  _SignupRouteState createState() => _SignupRouteState();
}

class _SignupRouteState extends State<SignupRoute> {
  final _formKey = GlobalKey<FormState>();
  late FirstName firstNameProvider;
  late LastName lastNameProvider;
  late Password passwordProvider;
  late Email emailProvider;
  bool passwordRetyped = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        firstNameProvider = Provider.of<FirstName>(context, listen: false);
        lastNameProvider = Provider.of<LastName>(context, listen: false);
        emailProvider = Provider.of<Email>(context, listen: false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double creditCard3dHeightRatio = 0.2;
    double titleheightRatio = 0.05;
    double largeSpacerRatio = 0.1;
    double smallSpacerRatio = 0.035;
    double textfieldHeight = size.height * 0.075;
    double textfieldWidth = size.width * 0.8;
    passwordProvider = Provider.of<Password>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            CreditCard3DContainer(
                height: size.height * creditCard3dHeightRatio),
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
              height: size.height * smallSpacerRatio,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextfieldContainer(
                      height: textfieldHeight,
                      width: textfieldWidth,
                      hintText: 'First name',
                      regexPattern: '^[A-Za-z]+\$',
                      matchFailedMessage: 'name must be alphabets and no space',
                      providerUpdater: (name) =>
                          firstNameProvider.setFirstName(name)),
                  SizedBox(
                    height: size.height * smallSpacerRatio,
                  ),
                  TextfieldContainer(
                      height: textfieldHeight,
                      width: textfieldWidth,
                      hintText: 'Last name',
                      regexPattern: '^[A-Za-z]+\$',
                      matchFailedMessage: 'name must be alphabets and no space',
                      providerUpdater: (name) =>
                          lastNameProvider.setLastName(name)),
                  SizedBox(
                    height: size.height * smallSpacerRatio,
                  ),
                  TextfieldContainer(
                    height: textfieldHeight,
                    width: textfieldWidth,
                    providerUpdater: (value) => emailProvider.setEmail(value),
                    hintText: 'Email',
                    regexPattern:
                        '^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&\'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\\.[a-zA-Z]+',
                    matchFailedMessage: 'Incorrect email format',
                  ),
                  SizedBox(
                    height: size.height * smallSpacerRatio,
                  ),
                  TextfieldContainer(
                    height: textfieldHeight,
                    width: textfieldWidth,
                    isPasswordField: true,
                    providerUpdater: (value) =>
                        passwordProvider.setPassword(value),
                    regexPattern: '^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$',
                    matchFailedMessage:
                        'minimum eight, atleast one letter and one number',
                    hintText: 'Password',
                  ),
                  SizedBox(
                    height: size.height * smallSpacerRatio,
                  ),
                  TextfieldContainer(
                    height: textfieldHeight,
                    width: textfieldWidth,
                    isPasswordField: true,
                    providerUpdater: (_) => setState(() {
                      passwordRetyped = true;
                    }),
                    regexPattern: '^${passwordProvider.password}\$',
                    matchFailedMessage: 'passwords must match',
                    hintText: 'Retype Password',
                  ),
                  SizedBox(
                    height: size.height * smallSpacerRatio,
                  ),
                  CustomButton(
                      width: textfieldWidth,
                      height: textfieldHeight * 0.9,
                      description: 'Signup',
                      onPressed: signup)
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  signup() {
    if (_formKey.currentState!.validate() && passwordRetyped) {
      setState(() {
        passwordRetyped = false;
      });
      print('yeeeeha');
    }
  }
}
