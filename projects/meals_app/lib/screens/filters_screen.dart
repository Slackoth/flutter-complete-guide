import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals_app/screens/main_drawer.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filter';
  
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      body: Center(child: Text('Filter'),)
    );
  }
}