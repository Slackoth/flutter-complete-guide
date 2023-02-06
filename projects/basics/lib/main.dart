import 'package:basics/log/getLogger.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BasicsApp());
}

class BasicsApp extends StatelessWidget  {
  static final log = getLogger();

  const BasicsApp({super.key});

  void answerQuestion() { log.i('answeringTheQuestion'); }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Basics')),
        body: Column(children: <Widget>[
          Text('Question...'),
          ElevatedButton(onPressed: answerQuestion, child: Text('Answer 1')),
          ElevatedButton(onPressed: answerQuestion, child: Text('Answer 2')),
          ElevatedButton(onPressed: answerQuestion, child: Text('Answer 3')),
        ],),
      )
    );
  }
}