import 'package:shop_app/domain/models/cart_item.dart';

class OrderItem {
  String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    this.id = 'false', 
    required this.amount, 
    required this.products,
    required this.dateTime
  });

  OrderItem.fromJson(Map<String, dynamic> json, this.id) : 
    amount = json['amount'],
    products = json['products'],
    dateTime = json['dateTime'];

  Map<String, dynamic> toJson(List<Map<String, dynamic>> products) => {
    'amount': amount,
    'products': products,
    'dateTime': dateTime.toIso8601String()
  };
}