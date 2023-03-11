import 'package:flutter/material.dart';
import 'package:shop_app/domain/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get size {
    return _items.length;
  }

  double get totalAmount {
    double totalAmount = 0;
    
    _items.forEach((key, value) {
      totalAmount += value.price * value.quantity;
    });

    return totalAmount;
  }

  void addItem(String productId, double price, String title) {
    if(_items.containsKey(productId)) {
      _items.update(productId, (existingItem) => CartItem(
        id: existingItem.id,
        title: existingItem.title,
        quantity: existingItem.quantity + 1,
        price: existingItem.price
      ));
    }
    else {
      _items.putIfAbsent(productId,
      () => CartItem(
        id: DateTime.now().toIso8601String(),
        price: price, 
        quantity: 1,
        title: title
      ));
    }

    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if(_items[id]!.quantity > 1) {
      _items.update(id, (existingItem) => CartItem(
        id: existingItem.id,
        title: existingItem.title,
        quantity: existingItem.quantity - 1,
        price: existingItem.price
      ));
    }
    else {
      _items.remove(id);
    }

    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Map<String, 
}