import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';
import '../utils/utils.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // List view needs a fixed space
        child: ListView.builder( // Loads only visible items
          itemBuilder: (context, index) {
            // Repeats this widget itemCount times
            return Card(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
                    ),
                    child: Text(
                      Utils.usdCurrencyFormat.format(transactions[index].amount),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions[index].title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleLarge
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy', 'en_US').format(transactions[index].date),
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
          },
          itemCount: transactions.length,
        ),
    );
  }
}