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
  final List<Map<String, Object>> _questions = [
    { 
      'questionText': 'What\'s Mr. Peanutbutter birthday?',
      'answers': ['08/69', '01/76', '10/99',]
    },
    {
      'questionText': 'Who\'s that dog?',
      'answers': ['Mr. Peanutbutter', 'Ringo', 'Magnus',]
    }
  ];

  void _answerQuestion() { 
    setState(() { _questionIndex++; });
    log.i('indexQuestion: $_questionIndex'); 
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
        ) :  const Result(),
      ),
    );
  }
}