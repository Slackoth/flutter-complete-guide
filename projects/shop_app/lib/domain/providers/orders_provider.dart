import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/domain/models/order_item.dart';
import '../../Utils/shop_app_utils.dart';
import '../models/cart_item.dart';

class OrdersProvider with ChangeNotifier {
  static const apiPath = '/orders.json';

  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  int get size {
    return _orders.length;
  }

  Future<void> addOrder(List<CartItem> items, double amount) async {
    final DateTime timestamp = DateTime.now();
    final Uri url = Uri.https(ShopAppUtils.firebaseUrl, apiPath);
    final OrderItem order = OrderItem(
      amount: amount, 
      products: items,
      dateTime: timestamp
    );

    try {
      items.map((product) => product.toJson()).toList();
      final http.Response response = await http.post(url, body: json.encode(order.toJson(
        items.map((product) => product.toJson()).toList()
      )));

      order.id = json.decode(response.body)['name'];
      _orders.insert(0, order);
      notifyListeners();
    } catch (error) { rethrow; }
  }
}