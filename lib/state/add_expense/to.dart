import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';

class AddExpenseTo extends ChangeNotifier {
  Contact? to;

  setTo(Contact? to) {
    this.to = to;
    notifyListeners();
  }
}
