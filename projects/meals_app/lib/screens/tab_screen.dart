import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/screens/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedScreen = 0;
  final List<Map<String, dynamic>> _screens = [
    { 'screen': const CategoriesScreen(), 'title': 'Catagories' },
    { 'screen': const FavoritesScreen(), 'title': 'Favorites' }
  ];

  void _selectScreen(int index) {
    setState(() { _selectedScreen = index; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_screens[_selectedScreen]['title'])),
      drawer: const MainDrawer(),
      body: _screens[_selectedScreen]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedScreen,
        type: BottomNavigationBarType.shifting, // Needs to style bar items
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.category), 
            label: 'Ingredients'
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.star), 
            label: 'Favorites'
          ),
        ],
      ),
    );
    // return DefaultTabController(initialIndex: 0, length: 2, child: 
    //   Scaffold(
    //     appBar: AppBar(
    //       title: const Text('DeliMeals'),
    //       bottom: const TabBar(tabs: [
    //         Tab(icon: Icon(Icons.category), text: 'Catagroies'),
    //         Tab(icon: Icon(Icons.star), text: 'Favorites'),
    //       ]),
    //     ),
    //     body: const TabBarView(children: [
    //       CategoriesScreen(),
    //       FavoritesScreen()
    //     ],),
    //   )
    // );
  }
}