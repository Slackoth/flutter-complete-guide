import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/Utils/shop_app_utils.dart';
import 'package:shop_app/domain/exceptions/http/http_exception.dart';
import 'package:shop_app/domain/providers/product_provider.dart';

class ProductsProvider with ChangeNotifier {
  static const apiPath = '/products.json';
  // Shouldn't do this here on the provider, instead, on a stateful widget
  // bool _showFavoritesOnly = false;

  // ignore: prefer_final_fields
  List<ProductProvider> _products = [
    // ProductProvider(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // ProductProvider(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // ProductProvider(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // ProductProvider(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  
  Future<void> fetchProducts() async {
    final Uri url = Uri.https(ShopAppUtils.firebaseUrl, apiPath);

    try {
      final http.Response response = await http.get(url);
      final Map<String, dynamic> data = json.decode(response.body) as Map<String, dynamic>;
      
      _products.clear();
      data.forEach((key, value) {
        _products.add(ProductProvider.fromJson(value, key));
      });
      notifyListeners();
    } catch (error) { rethrow; }
  }

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

  Future<void> addProduct(ProductProvider product) async {
    // return http.post(url, body: json.encode(product.toJson())).then((response) {
    //   final ProductProvider newProduct = ProductProvider.copy(
    //     product, 
    //     json.decode(response.body)['name']
    //   );
      
    //   _products.add(newProduct);
    //   notifyListeners();
    // }).catchError((error) => error);
    final Uri url = Uri.https(ShopAppUtils.firebaseUrl, apiPath);

    try {
      final http.Response response = await http.post(url, body: json.encode(product.toJson(false)));
      final ProductProvider newProduct = ProductProvider.copy(
        product, 
        json.decode(response.body)['name']
      );
      
      _products.add(newProduct);
      notifyListeners();
    } catch (error) { rethrow; }
  }

  Future<void> updateProduct(ProductProvider editedProduct) async {
    final index = _products.indexWhere((product) => product.id == editedProduct.id);
    
    if(index >= 0) {
      final Uri url = Uri.https(ShopAppUtils.firebaseUrl, '/products/${editedProduct.id}.json');
      
      try {
        await http.patch(url, body: json.encode(editedProduct.toJson(editedProduct.isFavorite)));
      } catch (error) { rethrow; }

      _products[index] = editedProduct;
      notifyListeners();
    }

    return Future.value(null);
  }

  Future<void> deleteProduct(String id) async {
    final Uri url = Uri.https(ShopAppUtils.firebaseUrl, '/products/$id.json');
    final existingProduct = ProductProvider.fullCopy(findById(id));

    _products.removeWhere((product) => product.id == id);
    notifyListeners();
    
    // Optimistic updating pattern 
    final http.Response response = await http.delete(url);
    
    if(response.statusCode >= 400) {
      _products.add(existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
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