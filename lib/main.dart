import 'package:credit_card/state/email.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/login.dart';
import 'state/password.dart';

void main() {
  runApp(MultiProvider(providers: [
    ListenableProvider<Password>(create: (_) => Password()),
    ListenableProvider<Email>(create: (_) => Email()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginRoute(),
    );
  }
}
