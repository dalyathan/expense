import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card/state/common/user_credential.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  static String expensesCollection = 'expenses';

  addDebt(String toEmail, String due, String summary, String amount,
      BuildContext context) {
    CollectionReference expenses =
        FirebaseFirestore.instance.collection(expensesCollection);
    String? myEmail = Provider.of<UserCredentialProvider>(context)
        .userCredential!
        .user!
        .email;
    if (myEmail == null) {
      throw Exception("my email is null");
    }
    expenses.add({
      'myEmail': myEmail,
      'toEmail': toEmail,
      'due': due,
      'summary': summary,
      'amount': amount
    });
  }
}
