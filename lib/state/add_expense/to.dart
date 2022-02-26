import 'package:flutter/foundation.dart';

class AddExpenseTo extends ChangeNotifier {
  late String to;

  setTo(String to) {
    this.to = to;
  }
}
