import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/products_provider.dart';
import 'package:shop_app/widgets/product/product_item.dart';

import '../../domain/providers/product_provider.dart';

class ProductsGrid extends StatelessWidget {
  
  const ProductsGrid({super.key, required this.showFavorites});

  final bool showFavorites;

  @override
  Widget build(BuildContext context) {
    // Only usable if some parent component has the Provider
    ProductsProvider provider = Provider.of<ProductsProvider>(context);
    List<ProductProvider> loadedProducts = showFavorites ? provider.favoriteProducts : provider.products;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
      ), 
      itemBuilder: (context, index) {
        // ChangeNotifierProvider.value should be use on something that's part of
        // a list or a grid. ChangeNotifierProvider will clean stored data
        return ChangeNotifierProvider.value(
          value: loadedProducts[index],
          child: const ProductItem()
        );
      },
    );
  }
}