import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../../domain/providers/product_provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final ProductProvider product = Provider.of<ProductProvider>(context);

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
              onPressed: () => product.toggleIsFavorite(),
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border)
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