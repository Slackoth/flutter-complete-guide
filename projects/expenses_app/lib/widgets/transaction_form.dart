import 'package:expenses_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class TransactionForm extends StatefulWidget { 
  static final Logger log = Utils.getLogger();
  
  final Function addNewTransaction;

  const TransactionForm({super.key, required this.addNewTransaction});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  DateTime? _selectedDate;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _onSubmittedTextField(String value) {
    final String title = _titleController.text;
    final double? amount = double.tryParse(_amountController.text);

    if(amount == null || title.isEmpty) {
      TransactionForm.log.i('Amount not a number or1 title empty');
      return;
    }
    else if(amount == 0) {
      TransactionForm.log.i('Amount equal to 0');
      return;
    }
    else if(_selectedDate == null) {
      TransactionForm.log.i('Date not selected');
      return;
    }

    // Access the properties and methods of the widget class inside the state class
    // This "widget" is a special property class-wise in the state class
    widget.addNewTransaction(title, amount, _selectedDate!);

    // Closes the top most screen that is displayed (the bottom modal sheet)
    // This "context" is a special property available class-wise in the state class
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker( // Future class (JS Promise like)
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2019), 
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10, 
            right: 10, 
            // viewInsets: Anything that's lapping into our view
            bottom: MediaQuery.of(context).viewInsets.bottom + 10, 
            left: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: _onSubmittedTextField,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                onSubmitted: _onSubmittedTextField,
              ),
              Container(
                margin: const EdgeInsets.only(top: 40, bottom: 40),
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null ? 
                      'No Date Chosen' : 
                      'Picked date: ${DateFormat('MMM dd, yyyy', 'en_US').format(_selectedDate!)}' 
                    ),
                  ),
                  TextButton(onPressed: _showDatePicker, child: const Text('Choose Date'))
                ],),
              ),
              TextButton(
                onPressed: () { _onSubmittedTextField('submitButton'); },
                style: ButtonStyle(
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)
                ),
                child: const Text('Add Transaction')
              )
            ],
          ),
        ),
      ),
    );
  }
}