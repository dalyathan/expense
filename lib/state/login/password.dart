import 'package:flutter/foundation.dart';

class Password extends ChangeNotifier {
  late String password;

  setPassword(String password) {
    this.password = password;
    notifyListeners();
  }
}
