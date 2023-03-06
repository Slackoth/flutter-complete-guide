import 'package:flutter/material.dart';

import '../widgets/product/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const String routeName = '/';
  
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop App')),
      body: const ProductsGrid(),
    );
  }
}