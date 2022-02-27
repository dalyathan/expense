import 'package:flutter/foundation.dart';

class WeeklyExpense extends ChangeNotifier {
  double expense = 0.0;

  setExpense(double expense) {
    this.expense = expense;
    notifyListeners();
  }
}
