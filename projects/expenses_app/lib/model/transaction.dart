import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date
  });

  @override
  String toString() {
    return 'Title: $title - Amount: $amount - Date: ${DateFormat('MMM dd, yyyy', 'en_US').format(date)}';
  }
}