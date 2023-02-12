import 'package:expenses_app/utils/utils.dart';
import 'package:flutter/material.dart';

class TransactionChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPorcentageOfTotal;
  
  const TransactionChartBar({super.key, required this.label, required this.spendingAmount, required this.spendingPorcentageOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FittedBox(child: Text(Utils.usdCurrencyFormat.format(spendingAmount))),
      const SizedBox(height: 4,),
      SizedBox(height: 60, width: 10, child: Stack(children: <Widget>[
        Container(decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          color: const Color.fromRGBO(220, 220, 220, 1),
          borderRadius: BorderRadius.circular(10)
        )),
        FractionallySizedBox(
          heightFactor: spendingPorcentageOfTotal,
          child: Container(decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10)
          )),
        ),
      ],)),
      Text(label)
    ]);
  }
}