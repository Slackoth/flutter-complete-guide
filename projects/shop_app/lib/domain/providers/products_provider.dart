import 'package:flutter/material.dart';
import 'package:shop_app/domain/providers/product_provider.dart';

class ProductsProvider with ChangeNotifier {
  // Shouldn't do this here on the provider, instead, on a stateful widget
  // bool _showFavoritesOnly = false;

  // ignore: prefer_final_fields
  List<ProductProvider> _products = [
    ProductProvider(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductProvider(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductProvider(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductProvider(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<ProductProvider> get products {
    // Shouldn't do this here on the provider, instead, on a stateful widget
    // if(_showFavoritesOnly) {
    //   return _products.where((product) => product.isFavorite).toList();
    // }
    // return [..._products];
    return [..._products];
  }

  List<ProductProvider> get favoriteProducts {
    // Shouldn't do this here on the provider, instead, on a stateful widget
    // if(_showFavoritesOnly) {
    //   return _products.where((product) => product.isFavorite).toList();
    // }
    // return [..._products];
    return _products.where((product) => product.isFavorite).toList();
  }

  ProductProvider findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  void addProduct(ProductProvider product) {
    final ProductProvider newProduct = ProductProvider.copy(product, DateTime.now().toIso8601String());

    _products.add(newProduct);
    notifyListeners();
  }

  // Shouldn't do this here on the provider, instead, on a stateful widget
  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }
}