import 'package:credit_card/state/add_expense/amount.dart';
import 'package:credit_card/state/add_expense/due.dart';
import 'package:credit_card/state/add_expense/summary.dart';
import 'package:credit_card/state/add_expense/to.dart';
import 'package:credit_card/state/signup/first_name.dart';
import 'package:credit_card/state/signup/last_name.dart';
import 'package:credit_card/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'routes/signin.dart';
import 'screen.dart';
import 'state/common/user_credential.dart';
import 'state/add_expense/title.dart';
import 'state/login/email.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/login/password.dart';
import 'state/total_expense/monthly.dart';
import 'state/total_expense/weekly.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ListenableProvider<Password>(create: (_) => Password()),
    ListenableProvider<Email>(create: (_) => Email()),
    ListenableProvider<FirstName>(create: (_) => FirstName()),
    ListenableProvider<LastName>(create: (_) => LastName()),
    ListenableProvider<UserCredentialProvider>(
        create: (_) => UserCredentialProvider()),
    ListenableProvider<AddExpenseTitle>(create: (_) => AddExpenseTitle()),
    ListenableProvider<AddExpenseAmount>(create: (_) => AddExpenseAmount()),
    ListenableProvider<AddExpenseSummary>(create: (_) => AddExpenseSummary()),
    ListenableProvider<AddExpenseTo>(create: (_) => AddExpenseTo()),
    ListenableProvider<AddDebtDue>(create: (_) => AddDebtDue()),
    ListenableProvider<WeeklyExpense>(create: (_) => WeeklyExpense()),
    ListenableProvider<MonthlyExpense>(create: (_) => MonthlyExpense()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await Firebase.initializeApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? googleUser = GoogleSignIn().currentUser;
    Widget nextScreen = const SafeArea(
        child: Scaffold(
            body: Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          color: MyTheme.darkBlue,
        ),
      ),
    )));
    return googleUser != null
        ? FutureBuilder<GoogleSignInAuthentication>(
            future: googleUser.authentication,
            builder: (BuildContext context,
                AsyncSnapshot<GoogleSignInAuthentication> snapshot) {
              if (snapshot.hasData) {
                final credential = GoogleAuthProvider.credential(
                  accessToken: snapshot.data!.accessToken,
                  idToken: snapshot.data!.idToken,
                );
                FirebaseAuth.instance
                    .signInWithCredential(credential)
                    .then((userCredential) {
                  Provider.of<UserCredentialProvider>(context, listen: false)
                      .setUserCredential(userCredential);
                  nextScreen = const MainScreen();
                });
              } else if (snapshot.hasError) {
                nextScreen = const SigninRoute();
              }
              return MaterialApp(home: nextScreen);
            })
        : const MaterialApp(home: SigninRoute());
  }
}
