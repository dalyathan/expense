import 'package:flutter/foundation.dart';

class WeeklyExpense extends ChangeNotifier {
  late double expense;

  setExpense(double expense) {
    this.expense = expense;
    notifyListeners();
  }
}
