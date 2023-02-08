import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final VoidCallback answerQuestion; // Function that recieves no arguments and returns no data

  const Answer(this.answerText, this.answerQuestion, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton( // ElevatedButton will take the style of the main theme
        child: Text(answerText),
        onPressed: answerQuestion,
      )
    );
  }
}