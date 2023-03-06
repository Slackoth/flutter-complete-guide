import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/products_provider.dart';
import 'package:shop_app/widgets/product/product_item.dart';

import '../../domain/models/product.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Only usable if some parent component has the Provider
    List<Product> loadedProducts = Provider.of<ProductsProvider>(context).products;

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
        return ProductItem(product: loadedProducts[index]);
      },
    );
  }
}