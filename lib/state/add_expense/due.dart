import 'package:flutter/foundation.dart';

class AddDebtDue extends ChangeNotifier {
  DateTime? due;

  setDate(DateTime due) {
    this.due = due;
    notifyListeners();
  }
}
