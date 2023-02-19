import 'package:expenses_app/widgets/transaction_list/transaction_list_item.dart';
import 'package:flutter/material.dart';

import '../../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList({super.key, required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {   
    return SizedBox(
      // height: 300, // List view needs a fixed space
        child: transactions.isEmpty ? 
         LayoutBuilder(
           builder: (context, constraints) {
            final double maxHeight = constraints.maxHeight;

            return Column(children: <Widget>[
              Text('No expenses...', style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: 10,), // SizedBox is commonly used as a separator
              SizedBox(height: maxHeight * 0.6, child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,))
            ]);
           }
         )
         : ListView.builder( // Loads only visible items
          itemBuilder: (context, index) {
            // Repeats this widget itemCount times
            return TransactionListItem(transaction: transactions[index], deleteTransaction: deleteTransaction);
          },
          itemCount: transactions.length,
        ),
    );
  }
}