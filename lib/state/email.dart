import 'package:flutter/foundation.dart';

class Email extends ChangeNotifier {
  late String email;

  setUsername(String email) {
    this.email = email;
    notifyListeners();
  }
}
