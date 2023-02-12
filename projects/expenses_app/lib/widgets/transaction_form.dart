import 'package:expenses_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TransactionForm extends StatefulWidget { 
  static final Logger log = Utils.getLogger();
  
  final Function addNewTransaction;

  const TransactionForm({super.key, required this.addNewTransaction});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  void _onSubmittedTextField(String value) {
    final String title = titleController.text;
    final double? amount = double.tryParse(amountController.text);

    if(amount == null || title.isEmpty) {
      TransactionForm.log.i('Amount not a number o title empty');
      return;
    }
    else if(amount == 0) {
      TransactionForm.log.i('Amount equal to 0');
      return;
    }

    // Access the properties and methods of the widget class inside the state class
    // This "widget" is a special property class-wise in the state class
    widget.addNewTransaction(title, amount);

    // Closes the top most screen that is displayed (the bottom modal sheet)
    // This "context" is a special property available class-wise in the state class
    Navigator.of(context).pop();
  }

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
              onSubmitted: _onSubmittedTextField,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
              onSubmitted: _onSubmittedTextField,
            ),
            TextButton(
              onPressed: () { _onSubmittedTextField('submitButton'); },
              style: TextButton.styleFrom(foregroundColor: Colors.purple),
              child: const Text('Add Transaction')
            )
          ],
        ),
      ),
    );
  }
}