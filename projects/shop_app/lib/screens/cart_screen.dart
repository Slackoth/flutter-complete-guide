import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/cart_provider.dart';
import 'package:shop_app/domain/providers/orders_provider.dart';
import 'package:shop_app/widgets/cart/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Shopping Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<CartProvider>(
                builder: (context, value, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 20),),
                    const Spacer(),
                    Chip(
                      elevation: 4,
                      label: Text(
                        '${value.totalAmount}',
                        style: TextStyle(color: theme.colorScheme.onPrimary),
                      ),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                    TextButton(
                      onPressed: () {
                        ordersProvider.addOrder(value.items.values.toList(), value.totalAmount);
                        value.clear();
                      },
                      child: const Text('ORDER NOW')
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Consumer<CartProvider>(
            builder: (context, value, child) => ListView.builder(
              itemCount: value.size,
              itemBuilder: (context, index) {
              return CartItemWidget(
                item: value.items.values.toList()[index],
                productId: value.items.keys.toList()[index],
              );
            },),
          ))
        ],
      ),
    );
  }
}