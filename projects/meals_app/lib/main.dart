import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';

void main() => runApp(const DeliMealsApp());

class DeliMealsApp extends StatelessWidget {
  const DeliMealsApp({super.key});

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
        '/': (context) => const CategoriesScreen(),
        /* Recieves a Map<String, String> [id, title] */
        CategoryMealsScreen.routeName: (context) => const CategoryMealsScreen(),
        MealDetailScreen.routeName:(context) => const MealDetailScreen()
      },
      // When route is not mapped
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) => const CategoriesScreen()),
      // When onGenerateRoute fails
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => const CategoriesScreen()),
    );
  }
}
