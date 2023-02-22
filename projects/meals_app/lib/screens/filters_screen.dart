import 'package:flutter/material.dart';
import 'package:meals_app/screens/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter';
  
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  
  const FiltersScreen({super.key, required this.saveFilters, required this.currentFilters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late bool _isGlutenFree;
  late bool _isLactoseFree;
  late bool _isVegetarian;
  late bool _isVegan;

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
  void initState() {
    super.initState();
    _isGlutenFree = widget.currentFilters['isGlutenFree']!;
    _isLactoseFree = widget.currentFilters['isLactoseFree']!;
    _isVegetarian = widget.currentFilters['isVegetarian']!;
    _isVegan = widget.currentFilters['isVegan']!;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(onPressed: () {
            widget.saveFilters(
              {
                'isGlutenFree': _isGlutenFree,
                'isLactoseFree': _isLactoseFree,
                'isVegetarian': _isVegetarian,
                'isVegan': _isVegan
              }
            );
          }, icon: const Icon(Icons.save))
        ],
      ),
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
            _isVegetarian, 
            (value) { setState(() { _isVegetarian = value; }); }
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