import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  ProductProvider({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.imageUrl, 
    required this.price, 
    this.isFavorite = false
  });

  void toggleIsFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  static ProductProvider copy(ProductProvider product, String id) {
    return ProductProvider(
      id: id, 
      title: product.title, 
      description: product.description, 
      imageUrl: product.imageUrl,
      price: product.price
    );
  }

  static ProductProvider fullCopy(ProductProvider product) {
    return ProductProvider(
      id: product.id, 
      title: product.title, 
      description: product.description, 
      imageUrl: product.imageUrl,
      price: product.price
    );
  }

  static ProductProvider empty() {
    return ProductProvider(id: '', title: '', description: '', imageUrl: '', price: 0);
  }
}