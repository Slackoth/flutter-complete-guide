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
    List<String> questions = ['What\'s Mr. Peanutbutter birthday?', 'Who\'s that dog?'];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Basics')),
        body: Column(children: <Widget>[
          Question(questions[_questionIndex]),
          Answer('Answer 1', _answerQuestion),
          Answer('Answer 2', _answerQuestion),
          Answer('Answer 2', _answerQuestion),
        ],),
      )
    );
  }
}