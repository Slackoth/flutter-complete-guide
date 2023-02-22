import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tab_screen.dart';
import 'package:meals_app/utils/dummy_meals.dart';

import 'domain/models/meal.dart';

void main() => runApp(const DeliMealsApp());

class DeliMealsApp extends StatefulWidget {
  const DeliMealsApp({super.key});

  @override
  State<DeliMealsApp> createState() => _DeliMealsAppState();
}

class _DeliMealsAppState extends State<DeliMealsApp> {
  Map<String, bool> _filters = {
    'isGlutenFree': false,
    'isLactoseFree': false,
    'isVegetarian': false,
    'isVegan': false
  };
  List<Meal> _meals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _saveFilters(Map<String, bool> filters) {
    setState(() { 
      _filters = filters; 
      _meals = DUMMY_MEALS.where((meal) {
        if(_filters['isGlutenFree']! && !meal.isGlutenFree) {
          return false;
        }
        
        if(_filters['isLactoseFree']! && !meal.isLactoseFree) {
          return false;
        }

        if(_filters['isVegetarian']! && !meal.isVegetarian) {
          return false;
        }

        if(_filters['isVegan']! && !meal.isVegan) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final index = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if(index >= 0) {
      setState(() { _favoriteMeals.removeAt(index); });
    }
    else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyMedium: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          titleLarge: TextStyle(fontSize: 24, fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold)
        ),
        colorScheme: ColorScheme
          .fromSwatch(primarySwatch: Colors.pink)
          .copyWith(secondary: Colors.amber)
      ),
      // home: const CategoriesScreen(),
      // initialRoute: '/route',
      routes: {
        '/': (context) => TabScreen(favoriteMeals: _favoriteMeals),
        /* Recieves a Map<String, String> [id, title] */
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(meals: _meals),
        MealDetailScreen.routeName:(context) => MealDetailScreen(toggleFavorite: _toggleFavorite, isMealFavorite: _isMealFavorite),
        FiltersScreen.routeName:(context) => FiltersScreen(saveFilters: _saveFilters, currentFilters: _filters),
      },
      // When route is not mapped
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) => const CategoriesScreen()),
      // When onGenerateRoute fails
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => const CategoriesScreen()),
    );
  }
}
