import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/orders_provider.dart';
import 'package:shop_app/widgets/orders/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final OrdersProvider provider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: provider.size,
        itemBuilder: (context, index) {
        return OrderItemWidget(item: provider.orders[index]);
      },),
    );
  }
}