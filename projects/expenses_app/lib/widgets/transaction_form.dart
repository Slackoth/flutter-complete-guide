import 'package:expenses_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TransactionForm extends StatelessWidget { 
  static final Logger log = Utils.getLogger();
  
  final Function addNewTransaction;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  
  TransactionForm({super.key, required this.addNewTransaction});

  void _onSubmittedTextField(String value) {
    final String title = titleController.text;
    final double? amount = double.tryParse(amountController.text);

    if(amount == null || title.isEmpty) {
      log.i('Amount not a number o title empty');
      return;
    }
    else if(amount == 0) {
      log.i('Amount equal to 0');
      return;
    }

    addNewTransaction(title, amount);
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