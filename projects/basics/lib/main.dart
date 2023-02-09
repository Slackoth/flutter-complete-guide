import 'package:basics/log/getLogger.dart';
import 'package:basics/widgets/quiz/answer.dart';
import 'package:basics/widgets/quiz/question.dart';
import 'package:basics/widgets/quiz/quiz.dart';
import 'package:basics/widgets/quiz/result.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/* 
final modifier locks the variable value at runtime 
const modifier locks the variable value before runtime (when compiling)
*/

void main() {
  runApp(const BasicsApp());
}

class BasicsApp extends StatefulWidget {
  const BasicsApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BasicsAppState();
  }
}

// Under score is the "private" modifier in Dart
class _BasicsAppState extends State<BasicsApp> {
  static final Logger log = getLogger();

  int _questionIndex = 0;
  int _totalScore = 0;
  final List<Map<String, Object>> _questions = [
    { 
      'questionText': 'What\'s Mr. Peanutbutter birthday?',
      'answers': [
        {'text': '08/69', 'score': 10},
        {'text': '07/70', 'score': 5},
        {'text': '06/71', 'score': 0},
      ]
    },
    {
      'questionText': 'Who\'s that dog?',
      'answers': [
        {'text': 'Mr. Peanutbutter', 'score': 10 },
        {'text': 'Ringo', 'score': 5 },
        {'text': 'Magnus', 'score': 0 },
      ]
    }
  ];

  void _answerQuestion(int score) { 
    setState(() { _questionIndex++; _totalScore += score; });
    log.i('indexQuestion: $_questionIndex'); 
  }

  void _resetQuiz() {
    setState(() { _questionIndex = 0; _totalScore = 0; });
    log.i('Quiz resetted!'); 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Basics')),
        body: _questionIndex < _questions.length ? 
        Quiz(
          questions: _questions, 
          answerQuestion: _answerQuestion, 
          questionIndex: _questionIndex
        ) : Result(resultScore: _totalScore, resetQuiz: _resetQuiz),
      ),
    );
  }
}