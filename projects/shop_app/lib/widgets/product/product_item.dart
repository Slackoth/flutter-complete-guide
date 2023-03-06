import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../../domain/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GestureDetector(
          onTap: () {
            navigator.pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id
            );
          },
          child: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              color: theme.colorScheme.secondary,
              onPressed: () {},
              icon: const Icon(Icons.favorite)
            ),
            trailing: IconButton(
              color: theme.colorScheme.secondary,
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart)
            ),
            title: Text(product.title, textAlign: TextAlign.center,),
          ),
        ),
        child: Image.network(product.imageUrl, fit: BoxFit.cover,)
      ),
    );
  }
}