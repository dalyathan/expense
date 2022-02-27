import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card/models/expenses.dart';
import 'package:credit_card/state/common/user_credential.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/debts.dart';

class DatabaseService {
  static String expensesCollection = 'expenses';

  static Future<void> addDebt(
      String to,
      DateTime due,
      String summary,
      String contactInfo,
      String amount,
      String title,
      BuildContext context) async {
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
      'to': to,
      'contactInfo': contactInfo,
      'due': due,
      'summary': summary,
      'amount': amount,
      'when': DateTime.now()
    });
  }

  static Future<void> addExpense(
    String title,
    String amount,
    String summary,
    String to,
    BuildContext context,
    String contactInfo,
    DateTime? due,
  ) async {
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
      'contactInfo': contactInfo,
      'due': due,
      'summary': summary,
      'amount': amount,
      'when': DateTime.now()
    });
  }

  static Future<List<Expenses>> getExpenses(BuildContext context) async {
    List<Expenses> expensesList = [];
    String? myEmail =
        Provider.of<UserCredentialProvider>(context, listen: false)
            .userCredential!
            .user!
            .email;
    CollectionReference<Map<String, dynamic>?> expenses =
        FirebaseFirestore.instance.collection(expensesCollection);
    QuerySnapshot<Map<String, dynamic>?> myExpenses =
        await expenses.where('me', isEqualTo: myEmail).get();
    for (var item in myExpenses.docs) {
      var data = item.data();
      // if (data != null && data.containsKey('due')) {
      //   expensesList.add(Debts.fromJson(data));
      // } else {
      expensesList.add(Expenses.fromJson(data!));
      //}
    }
    return expensesList;
  }
}
