import 'package:expenses_app/model/transaction.dart';
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
  final List<Transaction> transactions = [
    Transaction(
      id: "t1", 
      title: "DS",
      amount: 450.55,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2", 
      title: "GameCube",
      amount: 299.99,
      date: DateTime.now(),
    )
  ];
  
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses App'),
      ),
      body: Column(
        children: <Widget>[
          const Card(
            elevation: 5,
            child: SizedBox(
              width: double.infinity,
              child: Text('Chart')
            ),
          ),
          Column(
            children: transactions.map((transaction) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
                      child: Text(transaction.amount.toString()),
                    ),
                    Column(
                      children: [
                        Text(transaction.title),
                        Text(transaction.date.toString()),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          )
        ]
      ),
    );
  }
}