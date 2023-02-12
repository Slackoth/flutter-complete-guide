import 'package:expenses_app/widgets/transaction_chart/transaction_chart.dart';
import 'package:expenses_app/widgets/transaction_form.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'model/transaction.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        colorScheme: ColorScheme
          .fromSwatch(primarySwatch: Colors.deepPurple)
          .copyWith(secondary: Colors.amber),
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: 'OpenSans', fontSize: 18, fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        )
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: "t1", 
      title: "DS",
      amount: 450.05,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: "t2", 
      title: "GameCube",
      amount: 99999.99,
      date: DateTime.now(),
    )
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount) {
    final newTransaction = Transaction(
      id: DateTime.now().toIso8601String(), 
      title: title, 
      amount: amount,
      date: DateTime.now()
    );

    // log.i(newTransaction.toString());
    setState(() { _transactions.add(newTransaction); });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(context: context, builder: (builder) {
      return TransactionForm(addNewTransaction: _addNewTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses App'),
        actions: [
          IconButton(onPressed: () => _startAddNewTransaction(context), icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TransactionChart(recentTransactions: _recentTransactions),
            TransactionList(transactions: _transactions)
          ]
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}