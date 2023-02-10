import 'package:expenses_app/utils/utils.dart';
import 'package:expenses_app/widgets/transaction_form.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../model/transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  static final Logger log = Utils.getLogger();

  final List<Transaction> _transactions = [
    Transaction(
      id: "t1", 
      title: "DS",
      amount: 450.05,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2", 
      title: "GameCube",
      amount: 299.99,
      date: DateTime.now(),
    )
  ];

  void _addNewTransaction(String title, double amount) {
    final newTransaction = Transaction(
      id: DateTime.now().toIso8601String(), 
      title: title, 
      amount: amount,
      date: DateTime.now()
    );

    log.i(newTransaction.toString());
    setState(() { _transactions.add(newTransaction); });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TransactionForm(addNewTransaction: _addNewTransaction,),
      TransactionList(transactions: _transactions)
    ]);
  }
}