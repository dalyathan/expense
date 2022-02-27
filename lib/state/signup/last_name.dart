import 'package:flutter/foundation.dart';

class LastName extends ChangeNotifier {
  late String lastName;

  setLastName(String lastName) {
    this.lastName = lastName;
    notifyListeners();
  }
}
