import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Utils/shop_app_utils.dart';

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

  ProductProvider.fromJson(Map<String, dynamic> json, this.id) : 
    title = json['title'],
    description = json['description'],
    imageUrl = json['imageUrl'],
    price = json['price'],
    isFavorite = json['isFavorite'];

  Map<String, dynamic> toJson(bool isFavorite) => {
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'price': price,
    'isFavorite': isFavorite
  };

  Future<void> toggleIsFavorite() async {
    final bool oldStatus = isFavorite;
    isFavorite = !isFavorite;
    final Uri url = Uri.https(ShopAppUtils.firebaseUrl, '/products/$id.json');

    try {
      final http.Response response = await http.patch(url, body: json.encode({ 'isFavorite': isFavorite }));

      if(response.statusCode >= 400) {
        throw const HttpException('Updating failed!');
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }

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