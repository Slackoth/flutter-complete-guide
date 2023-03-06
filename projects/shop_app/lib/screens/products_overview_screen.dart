import 'package:flutter/material.dart';

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
          )
        ],
      ),
      body: ProductsGrid(showFavorites: _showFavoritesOnly),
    );
  }
}