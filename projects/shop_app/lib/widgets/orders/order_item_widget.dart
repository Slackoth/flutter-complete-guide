import 'package:flutter/material.dart';
import 'package:shop_app/domain/models/order_item.dart';
import 'package:intl/intl.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({super.key, required this.item});

  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('${item.amount}'),
            subtitle: Text(DateFormat('MM/dd/yyyy hh:mm').format(item.dateTime)),
            trailing: IconButton(
              onPressed: () {
                
              }, 
              icon: const Icon(Icons.expand_more)
            ),
          )
        ],
      ),
    );
  }
}