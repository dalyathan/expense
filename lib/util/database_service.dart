import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card/state/common/user_credential.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  static String expensesCollection = 'expenses';

  static Future<void> addDebt(String contact, String due, String summary,
      String amount, String title, BuildContext context) async {
    CollectionReference expenses =
        FirebaseFirestore.instance.collection(expensesCollection);
    String? myEmail =
        Provider.of<UserCredentialProvider>(context, listen: false)
            .userCredential!
            .user!
            .email;
    if (myEmail == null) {
      throw Exception("my email is null");
    }
    await expenses.add({
      'me': myEmail,
      'title': title,
      'to': contact,
      'due': due,
      'summary': summary,
      'amount': amount,
      'when': DateTime.now()
    });
  }

  static Future<void> addNormalExpense(String title, String amount,
      String summary, String to, BuildContext context) async {
    String? myEmail =
        Provider.of<UserCredentialProvider>(context, listen: false)
            .userCredential!
            .user!
            .email;
    CollectionReference expenses =
        FirebaseFirestore.instance.collection(expensesCollection);
    await expenses.add({
      'me': myEmail,
      'title': title,
      'to': to,
      'summary': summary,
      'amount': amount,
      'when': DateTime.now()
    });
  }
}
