import 'package:flutter/cupertino.dart';

class MonthlyExpense extends ChangeNotifier {
  double expense = 0.0;

  setExpense(double expense) {
    this.expense = expense;
    notifyListeners();
  }
}
