import 'package:expenses_app/widgets/user_transactions.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {  
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Expenses App'),
      ),
      body: Column(
        children: const <Widget>[
          Card(
            elevation: 5,
            child: SizedBox(
              width: double.infinity,
              child: Text('Chart')
            ),
          ),
          UserTransactions()
        ]
      ),
    );
  }
}