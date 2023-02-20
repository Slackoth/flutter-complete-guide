import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';

void main() => runApp(const DeliMealsApp());

class DeliMealsApp extends StatelessWidget {
  const DeliMealsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CategoriesScreen(),
    );
  }
}
