import 'package:flutter/material.dart';
import 'package:meals_app/domain/models/meal.dart';
import 'package:meals_app/utils/dummy_meals.dart';
import 'package:meals_app/widgets/meal/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final String categoryId;
  // final String categoryTitle;

  // const CategoryMealsScreen({super.key, required this.categoryId, required this.categoryTitle});

  static const routeName = '/category-meals';

  const CategoryMealsScreen({super.key});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> categoryMeals;
  bool _doneInitializing = false;
   
  void _removeMeal(String mealId) {
    setState(() { categoryMeals.removeWhere((meal) => meal.id == mealId); });
  }

  @override
  void didChangeDependencies() { // Runs befores build and has the context
    super.didChangeDependencies();
    
    if(!_doneInitializing) {
      final Map<String, String> routeArgs = ModalRoute.of(context)
        ?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      categoryMeals = DUMMY_MEALS.where((meal) => 
        meal.categories.contains(routeArgs['id']!)
      ).toList();
      _doneInitializing = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (context, index) => MealItem(
          id: categoryMeals[index].id,
          title: categoryMeals[index].title,
          imageUrl: categoryMeals[index].imageUrl,
          duration: categoryMeals[index].duration, 
          complexity: categoryMeals[index].complexity, 
          affordability: categoryMeals[index].affordability,
          removeMeal: _removeMeal,
        ), 
        itemCount: categoryMeals.length,
      )
    );
  }
}