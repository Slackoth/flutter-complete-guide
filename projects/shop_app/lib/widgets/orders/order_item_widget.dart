import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/domain/models/order_item.dart';
import 'package:intl/intl.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget({super.key, required this.item});

  final OrderItem item;

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('${widget.item.amount}'),
            subtitle: Text(DateFormat('MM/dd/yyyy hh:mm').format(widget.item.dateTime)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              }, 
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more)
            ),
          ),
          if(_expanded) Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(widget.item.products.length * 20.0 + 100, 180),
            child: ListView.builder(
              itemCount: widget.item.products.length,
              itemBuilder: (context, index) {
               return widget.item.products.map((e) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    e.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${e.quantity}x ${e.price}',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  )
               ])).toList()[index];
              }),
          )
        ],
      ),
    );
  }
}