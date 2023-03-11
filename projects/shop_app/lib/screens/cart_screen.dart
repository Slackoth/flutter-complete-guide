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
                    OrderButton(ordersProvider: ordersProvider, cart: value)
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
    required this.cart,
    required this.ordersProvider,
  });

  final CartProvider cart;
  final OrdersProvider ordersProvider;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.cart.totalAmount <= 0 ? null : () async {
        setState(() { _isLoading = true; });

        try {
          await widget.ordersProvider.addOrder(widget.cart.items.values.toList(), widget.cart.totalAmount);
          widget.cart.clear();
        } catch (error) {
          await showDialog<Null>(
            context: context, 
            builder: (context) => AlertDialog(
              title: const Text('An error ocurred!'),
              content: const Text('Something went wrong...'),
              actions: [
                TextButton(
                  onPressed: () { Navigator.of(context).pop(); },
                  child: const Text('Close')
                )
              ],
            ),
          );
        }
        finally { setState(() { _isLoading = false; }); }
      },
      child: _isLoading ? const CircularProgressIndicator() : const Text('ORDER NOW')
    );
  }
}