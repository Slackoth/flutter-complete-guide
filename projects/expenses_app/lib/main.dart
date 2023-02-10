import 'package:expenses_app/model/transaction.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
  static final Logger log = Utils.getLogger(); 

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
    
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
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: titleController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                ),
                TextButton(
                  onPressed: () {
                    log.i('Title: ${titleController.text} - Amount: ${amountController.text}');
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.purple),
                  child: const Text('Add Transaction'))
              ],),
            ),
          ),
          const TransactionList()
        ]
      ),
    );
  }
}