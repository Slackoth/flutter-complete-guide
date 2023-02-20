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
  final List<String> categories;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegeterian;

  const Meal({
    required this.id,
    required this.categories,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    this.isGlutenFree = false,
    this.isLactoseFree = false,
    this.isVegeterian = false
  });
}