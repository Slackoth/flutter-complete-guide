import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/cart_provider.dart';
import 'package:shop_app/widgets/cart/cart_badge.dart';

import '../widgets/product/products_grid.dart';

enum FilterOptions  { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  static const String routeName = '/';
  
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    // final ProductsProvider provider = Provider.of<ProductsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop App'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if(value == FilterOptions.favorites) {
                // provider.showFavoritesOnly();
                  _showFavoritesOnly = true;
                }
                else {
                  // provider.showAll();
                  _showFavoritesOnly = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Only Favorites')
              ),
              PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All')
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (context, value, child) => CartBadge(
              value: value.size,
              child: child!
            ),
            // It wont be rebuild because it's outside of the builder function
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart)
            ),
          )
        ],
      ),
      body: ProductsGrid(showFavorites: _showFavoritesOnly),
    );
  }
}