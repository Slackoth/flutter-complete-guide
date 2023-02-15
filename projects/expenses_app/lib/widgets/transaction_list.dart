import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';
import '../utils/utils.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList({super.key, required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // List view needs a fixed space
        child: transactions.isEmpty ? 
         Column(children: <Widget>[
          Text('No expenses...', style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(height: 10,), // SizedBox is commonly used as a separator
          SizedBox(height: 250, child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,))
         ],)
         : ListView.builder( // Loads only visible items
          itemBuilder: (context, index) {
            // Repeats this widget itemCount times
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  radius: 30, 
                  child: Padding(
                    padding: const EdgeInsets.all(5), 
                    child: FittedBox(child: Text(Utils.usdCurrencyFormat.format(transactions[index].amount))
                  ),
                )),
                title: Text(
                  transactions[index].title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge
                ),
                subtitle: Text(
                  DateFormat('MMM dd, yyyy', 'en_US').format(transactions[index].date),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  )
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete), 
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () { deleteTransaction(transactions[index].id); },
                ),
              ),
            );
            // return Card(
            //   child: Row(
            //     children: <Widget>[
            //       Container(
            //         padding: const EdgeInsets.all(5),
            //         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            //         ),
            //         child: Text(
            //           Utils.usdCurrencyFormat.format(transactions[index].amount),
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 20,
            //             color: Theme.of(context).colorScheme.primary
            //           ),
            //         ),
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
                      // Text(
                      //   transactions[index].title,
                      //   textAlign: TextAlign.left,
                      //   style: Theme.of(context).textTheme.titleLarge
                      // ),
                      // Text(
                      //   DateFormat('MMM dd, yyyy', 'en_US').format(transactions[index].date),
                      //   textAlign: TextAlign.left,
                      //   style: const TextStyle(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.grey
                      //   ),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // );
          },
          itemCount: transactions.length,
        ),
    );
  }
}