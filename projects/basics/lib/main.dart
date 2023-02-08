import 'package:basics/log/getLogger.dart';
import 'package:basics/widgets/answer.dart';
import 'package:basics/widgets/question.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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

  void _answerQuestion() { 
    setState(() { _questionIndex++; });
    log.i('indexQuestion: $_questionIndex'); 
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> questions = [
      { 
        'questionText': 'What\'s Mr. Peanutbutter birthday?',
        'answers': ['08/69', '01/76', '10/99',]
      },
      {
        'questionText': 'Who\'s that dog?',
        'answers': ['Mr. Peanutbutter', 'Ringo', 'Magnus',]
      }
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Basics')),
        body: Column(children: <Widget>[
          Question(questions[_questionIndex]['questionText'] as String),
          // Spread operator. Same as the JS operator
          ...(questions[_questionIndex]['answers'] as List<String>).map((answer) {
            return Answer(answer, _answerQuestion);
          }).toList()
        ],),
      )
    );
  }
}