import 'package:flutter/foundation.dart';

class AddExpenseAmount extends ChangeNotifier {
  late String amount;

  setAmount(String amount) {
    this.amount = amount;
  }
}
