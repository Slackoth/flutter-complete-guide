import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(initialIndex: 0, length: 2, child: 
      Scaffold(
        appBar: AppBar(
          title: const Text('DeliMeals'),
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.category), text: 'Catagroies'),
            Tab(icon: Icon(Icons.star), text: 'Favorites'),
          ]),
        ),
        body: const TabBarView(children: [
          CategoriesScreen(),
          FavoritesScreen()
        ],),
      )
    );
  }
}