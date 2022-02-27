import 'package:credit_card/models/expenses.dart';

class Debts extends Expenses {
  final String due;

  Debts(title, to, this.due, summary, amount, when)
      : super(title, to, summary, amount, when);
}
