import 'package:flutter/material.dart';
import 'package:shop_app/domain/models/order_item.dart';

import '../models/cart_item.dart';

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> items, double amount) {
    _orders.insert(0, OrderItem(
      id: DateTime.now().toIso8601String(), 
      amount: amount, 
      products: items
    ));
    notifyListeners();
  }
}