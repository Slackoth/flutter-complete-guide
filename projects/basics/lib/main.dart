import 'package:basics/log/getLogger.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const BasicsApp());
}

class BasicsApp extends StatefulWidget {
  const BasicsApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return BasicsAppState();
  }
}

class BasicsAppState extends State<BasicsApp> {
  static final Logger log = getLogger();

  int questionIndex = 0;

  void answerQuestion() { 
    setState(() { questionIndex++; });
    log.i('indexQuestion: $questionIndex'); 
  }

  @override
  Widget build(BuildContext context) {
    List<String> questions = ['What\'s Mr. Peanutbutter birthday?', 'Who\'s that dog?'];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Basics')),
        body: Column(children: <Widget>[
          Text(questions[questionIndex]),
          ElevatedButton(onPressed: answerQuestion, child: Text('Answer 1')),
          ElevatedButton(onPressed: answerQuestion, child: Text('Answer 2')),
          ElevatedButton(onPressed: answerQuestion, child: Text('Answer 3')),
        ],),
      )
    );
  }
}