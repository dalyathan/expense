import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card/models/expenses.dart';
import 'package:credit_card/state/common/user_credential.dart';
import 'package:credit_card/state/total_expense/weekly.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../state/total_expense/monthly.dart';

class DatabaseService {
  static String expensesCollection = 'expenses';

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
      expensesList.add(Expenses.fromJson(data!));
    }
    calculatedTimelyExpenses(expensesList, context);
    return expensesList;
  }

  static calculatedTimelyExpenses(
      List<Expenses> expenses, BuildContext context) {
    DateTime today = DateTime.now();
    double monthly = 0;
    double weekly = 0;
    for (var expense in expenses) {
      var when = expense.when;
      if (when.year == today.year && when.month == today.month) {
        monthly += double.tryParse(expense.amount) ?? 0;
        if (today.weekday >= when.weekday && today.day >= when.day) {
          weekly += double.tryParse(expense.amount) ?? 0;
        }
      }
    }

    Provider.of<MonthlyExpense>(context, listen: false).setExpense(monthly);
    Provider.of<WeeklyExpense>(context, listen: false).setExpense(weekly);
  }
}
