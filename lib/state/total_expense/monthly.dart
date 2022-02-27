import 'package:flutter/cupertino.dart';

class MonthlyExpense extends ChangeNotifier {
  late double expense;

  setExpense(double expense) {
    this.expense = expense;
  }
}
