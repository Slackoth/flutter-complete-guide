import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/cart_provider.dart';

import '../../domain/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.item, required this.productId});

  final CartItem item;
  final String productId;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Dismissible(
      key: ValueKey(item.id),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure'),
            content: const Text('Would you like to remove the item from the cart?'),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop(false);
              }, child: const Text('No')),
              TextButton(onPressed: () {
                Navigator.of(context).pop(true);
              }, child: const Text('Yes'))
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: theme.colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Icon(Icons.delete, size: 40, color: theme.colorScheme.onPrimary),
      ),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary, 
              child: 
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: FittedBox(child: Text(item.price.toStringAsFixed(2))),
                )
            ),
            title: Text(item.title),
            subtitle: Text('Total: ${item.quantity * item.price}'),
            trailing: Text('${item.quantity}'),
          ),
        ),
      ),
    );
  }
}