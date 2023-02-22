import 'package:flutter/material.dart';
import 'package:meals_app/utils/dummy_meals.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  
  const MealDetailScreen({super.key});

  Container _buildSectionTitle(String text, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
  
  Container _buildContainerList(Widget child) {
    return Container(height: 200, width: double.infinity, 
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10)
      ),
      child: child
    );
  }

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    
    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 300, width: double.infinity, 
            child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover,),
          ),
          _buildSectionTitle('Ingredients', context),
          _buildContainerList(
              ListView.builder(itemBuilder: (context, index) => 
                Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedMeal.ingredients[index]),
                  )
                ), 
                itemCount: selectedMeal.ingredients.length
              )
          ),
          _buildSectionTitle('Steps', context),
          _buildContainerList(
            ListView.builder(itemBuilder: (context, index) => 
                Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        child: Text('${index + 1}')
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    const Divider()
                  ],
                ), 
                itemCount: selectedMeal.steps.length
              )
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(mealId),
        child: const Icon(Icons.delete),
      ),
    );
  }
}