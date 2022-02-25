import 'package:flutter/foundation.dart';

class Email extends ChangeNotifier {
  late String email;

  setEmail(String email) {
    this.email = email;
    notifyListeners();
  }
}
