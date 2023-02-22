import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  ListTile _buildListTile(String text, IconData icon, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 25),
      title: Text(
        text,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).colorScheme.secondary,
          child: Text(
            'Cooking Up!',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Theme.of(context).colorScheme.primary
            ),
          )
        ),
        const SizedBox(height: 20),
        _buildListTile('Meals', Icons.restaurant, () => Navigator.of(context).pushNamed('/')),
        _buildListTile('Filter', Icons.settings, () => Navigator.of(context).pushNamed(FiltersScreen.routeName))
      ],),
    );
  }
}