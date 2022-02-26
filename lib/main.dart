import 'package:credit_card/state/signup/first_name.dart';
import 'package:credit_card/state/signup/last_name.dart';
import 'package:credit_card/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes/signin.dart';
import 'screen.dart';
import 'state/common/user_credential.dart';
import 'state/login/email.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/login.dart';
import 'state/login/password.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ListenableProvider<Password>(create: (_) => Password()),
    ListenableProvider<Email>(create: (_) => Email()),
    ListenableProvider<FirstName>(create: (_) => FirstName()),
    ListenableProvider<LastName>(create: (_) => LastName()),
    ListenableProvider<UserCredentialProvider>(
        create: (_) => UserCredentialProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      await Firebase.initializeApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: prefs,
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          Widget nextScreen;
          if (snapshot.hasData) {
            String? accessToken =
                snapshot.data!.getString('googleAuth?.accessToken');
            String? idToken = snapshot.data!.getString('googleAuth?.idToken');
            if (accessToken != null && idToken != null) {
              final credential = GoogleAuthProvider.credential(
                accessToken: accessToken,
                idToken: idToken,
              );

              FirebaseAuth.instance.signInWithCredential(credential).then(
                  (userCredential) => Provider.of<UserCredentialProvider>(
                          context,
                          listen: false)
                      .setUserCredential(userCredential));

              nextScreen = const MainScreen();
            } else {
              nextScreen = const SigninRoute();
            }
          } else if (snapshot.hasError) {
            nextScreen = const CircularProgressIndicator(
              color: Colors.red,
            );
          } else {
            nextScreen = const CircularProgressIndicator(
              color: MyTheme.darkBlue,
            );
          }
          return MaterialApp(home: nextScreen);
        });
  }
}
