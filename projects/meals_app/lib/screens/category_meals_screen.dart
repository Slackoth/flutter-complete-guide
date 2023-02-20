import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  // final String categoryId;
  // final String categoryTitle;

  // const CategoryMealsScreen({super.key, required this.categoryId, required this.categoryTitle});
  const CategoryMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(title: Text(routeArgs['title']!)),
      body: const Center(child: Text('Recipes For The Catagory'))
    );
  }
}