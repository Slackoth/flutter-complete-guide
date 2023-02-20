import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  // final String categoryId;
  // final String categoryTitle;

  // const CategoryMealsScreen({super.key, required this.categoryId, required this.categoryTitle});

  static const routeName = '/category-meals';

  const CategoryMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String categoryId = routeArgs['id']!;
    final String categoryTitle = routeArgs['title']!;

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(itemBuilder: (context, index) => {
        
      })
    );
  }
}