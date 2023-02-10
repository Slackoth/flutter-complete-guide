import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget { 
  final Function addNewTransaction;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  
  TransactionForm({super.key, required this.addNewTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                addNewTransaction(titleController.text, double.parse(amountController.text));
              },
              style: TextButton.styleFrom(foregroundColor: Colors.purple),
              child: const Text('Add Transaction')
            )
          ],
        ),
      ),
    );
  }
}