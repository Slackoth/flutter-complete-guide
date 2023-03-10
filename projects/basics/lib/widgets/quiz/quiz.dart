import 'package:basics/widgets/quiz/question.dart';
import 'package:flutter/material.dart';

import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function answerQuestion;
  final int questionIndex;
  
  const Quiz({
    required this.questions, 
    required this.answerQuestion, 
    required this.questionIndex, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Question(questions[questionIndex]['questionText'] as String),
      ...(questions[questionIndex]['answers'] as List<Map<String, Object>>).map((answer) {
            return Answer(
              answer['text'] as String, 
              () => answerQuestion(answer['score'] as int)
            );
      }).toList()
    ],);
  }
}