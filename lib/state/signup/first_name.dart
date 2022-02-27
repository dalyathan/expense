import 'package:flutter/foundation.dart';

class FirstName extends ChangeNotifier {
  late String firstName;

  setFirstName(String firstName) {
    this.firstName = firstName;
    notifyListeners();
  }
}
