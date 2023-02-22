import 'package:flutter/material.dart';
import 'package:meals_app/utils/dummy_categories.dart';
import 'package:meals_app/widgets/category/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // No need for Scaffold when using DefaultTabController
    return GridView(
      padding: const EdgeInsets.all(25),
      // Slivers are scrollable views
      // MaxCrossAxisExtents allows to define a maximum width for a grid
      // for each grid item. And then automatically create as many columns
      // as we can fit items with that provided width next to each other.
      // If we have a device with 300px width, then we'll have only one item per row.
      // If we have a device with 500px width, then we'll have two items per row.
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
      ),
      children: [
        ...DUMMY_CATEGORIES.map(
          (category) => CategoryItem(title: category.title, color: category.color, id: category.id,)
        ).toList()
      ],
    );
    // return Scaffold(
    //   appBar: AppBar(title: const Text('DeliMeals')),
    //   body: GridView(
    //     padding: const EdgeInsets.all(25),
    //     // Slivers are scrollable views
    //     // MaxCrossAxisExtents allows to define a maximum width for a grid
    //     // for each grid item. And then automatically create as many columns
    //     // as we can fit items with that provided width next to each other.
    //     // If we have a device with 300px width, then we'll have only one item per row.
    //     // If we have a device with 500px width, then we'll have two items per row.
    //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //       maxCrossAxisExtent: 200,
    //       childAspectRatio: 1.5,
    //       crossAxisSpacing: 20,
    //       mainAxisSpacing: 20
    //     ),
    //     children: [
    //       ...DUMMY_CATEGORIES.map(
    //         (category) => CategoryItem(title: category.title, color: category.color, id: category.id,)
    //       ).toList()
    //     ],
    //   ),
    // );
  }
}