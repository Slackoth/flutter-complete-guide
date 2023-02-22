import 'package:flutter/material.dart';
import 'package:meals_app/utils/dummy_meals.dart';
import 'package:meals_app/widgets/meal/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  // final String categoryId;
  // final String categoryTitle;

  // const CategoryMealsScreen({super.key, required this.categoryId, required this.categoryTitle});

  static const routeName = '/category-meals';

  const CategoryMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id']!;
    final categoryTitle = routeArgs['title']!;
    final categoryMeals = DUMMY_MEALS.where((meal) => 
      meal.categories.contains(categoryId)
    ).toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (context, index) => MealItem(
          title: categoryMeals[index].title,
          imageUrl: categoryMeals[index].imageUrl,
          duration: categoryMeals[index].duration, 
          complexity: categoryMeals[index].complexity, 
          affordability: categoryMeals[index].affordability
        ), 
        itemCount: categoryMeals.length,
      )
    );
  }
}