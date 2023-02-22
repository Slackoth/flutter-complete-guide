import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals_app/screens/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter';
  
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegeterian = false;
  bool _isVegan = false;

  SwitchListTile _buildSwitchListTile(String title, String subtitle, 
  bool currentValue, Function onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue, 
      subtitle: Text(subtitle),
      onChanged: (value) => onChanged(value),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      drawer: const MainDrawer(),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Adjust your meal selection.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(child: ListView(children: [
          _buildSwitchListTile(
            'Gluten Free', 
            'Ony include gluten free meals.', 
            _isGlutenFree, 
            (value) { setState(() { _isGlutenFree = value; }); }
          ),
          _buildSwitchListTile(
            'Lactose Free', 
            'Ony include lactose free meals.', 
            _isLactoseFree, 
            (value) { setState(() { _isLactoseFree = value; }); }
          ),
          _buildSwitchListTile(
            'Vegeterian', 
            'Ony include vegeterian meals.', 
            _isVegeterian, 
            (value) { setState(() { _isVegeterian = value; }); }
          ),
          _buildSwitchListTile(
            'Vegan', 
            'Ony include vegan meals.', 
            _isVegan, 
            (value) { setState(() { _isVegan = value; }); }
          )
        ]))
      ],)
    );
  }
}