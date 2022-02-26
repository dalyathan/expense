import 'package:flutter/foundation.dart';

class AddExpenseSummary extends ChangeNotifier {
  late String summary;

  setSummary(String summary) {
    this.summary = summary;
  }
}
