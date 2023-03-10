import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/cart_provider.dart';
import 'package:shop_app/domain/providers/products_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/cart/cart_badge.dart';

import '../widgets/product/products_grid.dart';
import 'main_drawer.dart';

enum FilterOptions  { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  static const String routeName = '/';
  
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  bool _showFavoritesOnly = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() { _isLoading = true; });

    if(_isInit) {
      Provider.of<ProductsProvider>(context).fetchProducts()
        .catchError((error) => 
          showDialog<Null>(
            context: context, 
            builder: (context) => AlertDialog(
              title: const Text('An error ocurred!'),
              content: const Text('Something went wrong...'),
              actions: [
                TextButton(
                  onPressed: () { Navigator.of(context).pop(); },
                  child: const Text('Close')
                )
              ],
            ),
          )
        )
        .then((value) {
          setState(() { _isLoading = false; });
        });
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);
    // final ProductsProvider provider = Provider.of<ProductsProvider>(context, listen: false);

    return Scaffold(
      drawer: const MainDrawer(),
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
              onPressed: () {
                navigator.pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart)
            ),
          )
        ],
      ),
      body: ProductsGrid(showFavorites: _showFavoritesOnly),
    );
  }
}