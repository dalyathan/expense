import 'package:credit_card/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../screen.dart';
import '../../../state/common/user_credential.dart';

class SigninOptions extends StatefulWidget {
  final double width;
  const SigninOptions({Key? key, required this.width}) : super(key: key);

  @override
  State<SigninOptions> createState() => _SigninOptionsState();
}

class _SigninOptionsState extends State<SigninOptions> {
  late UserCredentialProvider userCredentialProvider;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        userCredentialProvider =
            Provider.of<UserCredentialProvider>(context, listen: false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? const SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: MyTheme.darkBlue,
            ),
          )
        : SizedBox(
            width: widget.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async => await tryGoogleLogin(context),
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.google,
                        color: MyTheme.darkBlue,
                        size: widget.width * 0.2,
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      const Text(
                        "Signin with Google",
                        style: TextStyle(
                            fontSize: 10,
                            color: MyTheme.lightBlue,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Text(
                  "Or",
                  style: TextStyle(
                      fontSize: 15,
                      color: MyTheme.darkBlue,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.fingerprint,
                      color: MyTheme.darkBlue,
                      size: widget.width * 0.2,
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    const Text(
                      "Scan your fingerprint",
                      style: TextStyle(
                          fontSize: 10,
                          color: MyTheme.lightBlue,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  tryGoogleLogin(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await signInWithGoogle();
      userCredentialProvider.setUserCredential(userCredential);
      setState(() {
        isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Unable to login'),
      ));
      rethrow;
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Unable to login. Please check your internet connection and try again.'),
      ));
      rethrow;
    }
  }
}
