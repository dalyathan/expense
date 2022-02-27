import 'package:flutter/foundation.dart';

class AddExpenseTitle extends ChangeNotifier {
  late String title;

  setTitle(String title) {
    this.title = title;
    notifyListeners();
  }
}
