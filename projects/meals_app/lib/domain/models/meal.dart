enum Complexity {
  simple,
  challenging,
  hard 
}

enum Affordability {
  affordable,
  pricey,
  luxurious 
}

class Meal {
  final String id;
  final String title;
  final List<String> categories;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegetarian;
  final bool isVegan;

  const Meal({
    required this.id,
    required this.title,
    required this.categories,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    this.isGlutenFree = false,
    this.isLactoseFree = false,
    this.isVegetarian = false,
    this.isVegan = false
  });
}