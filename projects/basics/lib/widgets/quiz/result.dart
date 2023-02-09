import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetQuiz;

  const Result({super.key, required this.resultScore, required this.resetQuiz});

  String get resultPhrase {
    switch(resultScore) {
      case 20: return 'Is this a crossover episode?';
      case 15: return 'Birthday Dad';
      case 10: return 'Mr. Peanutbutter\'s House';
      case 5: return 'Mr. Peanut Butter';
      case 0: 
      default: return 'Sad Dog';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase, 
            textAlign: TextAlign.center, 
            style: const TextStyle(fontSize: 28)
          ),
          TextButton(
            onPressed: resetQuiz, child: const Text('Again?')
          ),
        ],
      ),
    );
  }
}