import 'package:expenses_app/model/transaction.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
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
          Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                const TextField(decoration: InputDecoration(labelText: 'Title'),),
                const TextField(decoration: InputDecoration(labelText: 'Amount'),),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: Colors.purple),
                  child: const Text('Add Transaction'))
              ],),
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
                      decoration: BoxDecoration(border: Border.all(color: Colors.purple, width: 2)),
                      child: Text(
                        Utils.usdCurrencyFormat.format(transaction.amount),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy', 'en_US').format(transaction.date),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ),
                        ),
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