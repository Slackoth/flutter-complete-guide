import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/transaction.dart';
import '../../utils/utils.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  const TransactionListItem({
    super.key,
    required this.transaction,
    required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

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
            child: FittedBox(child: Text(Utils.usdCurrencyFormat.format(transaction.amount))
          ),
        )),
        title: Text(
          transaction.title,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleLarge
        ),
        subtitle: Text(
          DateFormat('MMM dd, yyyy', 'en_US').format(transaction.date),
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          )
        ),
        trailing: 
        mediaQuery.size.width > 360 ? 
          TextButton.icon(
            onPressed: () { deleteTransaction(transaction.id); },
            icon: const Icon(Icons.delete),
            label: const Text('Delete'),
            style: ButtonStyle(
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
              backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.error),
            ),
          ) :
          IconButton(
            icon: const Icon(Icons.delete), 
            color: Theme.of(context).colorScheme.error,
            onPressed: () { deleteTransaction(transaction.id); },
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
    //           Text(
    //             transactions[index].title,
    //             textAlign: TextAlign.left,
    //             style: Theme.of(context).textTheme.titleLarge
    //           ),
    //           Text(
    //             DateFormat('MMM dd, yyyy', 'en_US').format(transactions[index].date),
    //             textAlign: TextAlign.left,
    //             style: const TextStyle(
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.grey
    //             ),
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}