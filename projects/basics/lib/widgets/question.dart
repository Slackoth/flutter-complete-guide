import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  
  final String questionText;

  const Question(this.questionText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // All space available
      margin: EdgeInsets.all(10), // Margin in all directions (top, right, bottom, left)
      child: Text(
        questionText, 
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,)
      );
  }
}