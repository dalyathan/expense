import 'package:flutter/foundation.dart';

class AddDebtDue extends ChangeNotifier {
  String? due;

  setDate(String due) {
    this.due = due;
    notifyListeners();
  }
}
