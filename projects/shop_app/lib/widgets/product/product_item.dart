import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/cart_provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../../domain/providers/product_provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    // Will not rebuild whole component 
    final ProductProvider product = Provider.of<ProductProvider>(context, listen: false);

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
            // Consumer works the same way of Provider.of<>() but the advantage is
            // that it can be used on specific components, rebuilding only the specific
            // component, such as the widget on the leading
            leading: Consumer<ProductProvider>(
              child: const Text('Component that must\'nt change passed as the child parameter'),
              builder: (context, value, child) => IconButton(
                color: theme.colorScheme.secondary,
                onPressed: () => value.toggleIsFavorite(),
                icon: Icon(value.isFavorite ? Icons.favorite : Icons.favorite_border)
              ),
            ),
            trailing: IconButton(
              color: theme.colorScheme.secondary,
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
              },
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