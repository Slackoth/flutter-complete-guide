import 'package:flutter/material.dart';

void main() {
  runApp(const BasicsApp());
}

class BasicsApp extends StatelessWidget  {
  const BasicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Basics')),
        body: const Text('How to Flutter!'),
      )
    );
  }
}