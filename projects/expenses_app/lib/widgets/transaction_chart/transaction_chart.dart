import 'package:expenses_app/model/transaction.dart';
import 'package:expenses_app/widgets/transaction_chart/transaction_chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionChart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  
  const TransactionChart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      double totalAmount = 0.0;
      int length = recentTransactions.length;
      final DateTime weekDay = DateTime.now().subtract(Duration(days: index));

      for (int i = 0; i < length; i++) {
        if(
          recentTransactions[i].date.day == weekDay.day &&
          recentTransactions[i].date.month == weekDay.month &&
          recentTransactions[i].date.year == weekDay.year 
        ) { totalAmount += recentTransactions[i].amount; }
      }

      return { 'day': DateFormat.E().format(weekDay), 'amount': totalAmount };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0, (total, item) {
      return total + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(elevation: 6, margin: const EdgeInsets.all(10), child: Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: 
          groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: TransactionChartBar(
                label: data['day'] as String, 
                spendingAmount: data['amount'] as double,
                spendingPorcentageOfTotal: maxSpending == 0 ? 0 : (data['amount'] as double) / maxSpending
              ),
            );
          }).toList()
      ),
    ));
  }
}