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
}