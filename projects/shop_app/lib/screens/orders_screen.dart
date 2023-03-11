import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/orders_provider.dart';
import 'package:shop_app/widgets/orders/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const String routeName = '/orders';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<OrdersProvider>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    // final OrdersProvider provider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.error != null) {
            return const Text('Something went wrong...');
          }
          else {
            return RefreshIndicator(
              onRefresh: () { return _refreshProducts(context); },
              child: Consumer<OrdersProvider>(
                builder: (context, value, child) => ListView.builder(
                  itemCount: value.size,
                  itemBuilder: (context, index) {
                  return OrderItemWidget(item: value.orders[index]);
                }),
              ),
            );
          }
        },
      )
    );
  }
}