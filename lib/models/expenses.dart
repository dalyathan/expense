import 'package:cloud_firestore/cloud_firestore.dart';

class Expenses {
  final String title;
  final String to;
  final String contactInfo;
  final String summary;
  final String amount;
  final DateTime when;
  final DateTime? due;

  Expenses(this.title, this.to, this.contactInfo, this.summary, this.amount,
      this.when, this.due);

  factory Expenses.fromJson(Map<String, dynamic> json) {
    DateTime? due;
    if (json['due'] != null) {
      due = DateTime.fromMicrosecondsSinceEpoch(
          (json['due'] as Timestamp).microsecondsSinceEpoch);
    }
    return Expenses(
        json['title'] as String,
        json['to'] as String,
        json['contactInfo'] as String,
        json['summary'] as String,
        json['amount'] as String,
        DateTime.fromMicrosecondsSinceEpoch(
            (json['when'] as Timestamp).microsecondsSinceEpoch),
        due);
  }
}
