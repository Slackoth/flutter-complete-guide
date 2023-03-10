import 'package:flutter/material.dart';
import 'package:meals_app/domain/models/meal.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  // final Function removeMeal;
  
  const MealItem({super.key, required this.title, required this.imageUrl, required this.duration, required this.complexity, required this.affordability, required this.id});

  void _selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(MealDetailScreen.routeName, arguments: id);
      // .then((mealId) {
      //   if(mealId != null) {
      //     removeMeal(mealId);
      //   }
      // });
  }

  String get complexityText {
    switch (complexity) {
      case Complexity.simple: return 'Simple';
      case Complexity.challenging: return 'Challenging';
      case Complexity.hard: return 'Hard';
      default: return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.affordable: return 'Affordable';
      case Affordability.pricey: return 'Pricey';
      case Affordability.luxurious: return 'Luxurious';
      default: return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectMeal(context),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          Stack(children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)
              ),
              child: Image.network(
                imageUrl, 
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover
              ),
            ),
            Positioned( // Only stacks: Absolute position
              bottom: 20,
              right: 10,
              child: Container(
                width: 300,
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white
                  ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            )
          ]),
          Padding(padding: const EdgeInsets.all(20), child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(children: [
                const Icon(Icons.schedule),
                const SizedBox(width: 6,),
                Text('$duration min')
              ]),
              Row(children: [
                const Icon(Icons.work),
                const SizedBox(width: 6,),
                Text(complexityText)
              ]),
              Row(children: [
                const Icon(Icons.monetization_on),
                const SizedBox(width: 6,),
                Text(affordabilityText)
              ],)
          ]))
        ]),
      ),
    );
  }
}