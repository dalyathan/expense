import 'package:credit_card/state/signup/first_name.dart';
import 'package:credit_card/state/signup/last_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';

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
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      await Firebase.initializeApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginRoute(),
    );
  }
}
