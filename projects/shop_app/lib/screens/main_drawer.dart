import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    NavigatorState navigator = Navigator.of(context);

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Shop! Shop! Shop!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              navigator.pushNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              navigator.pushNamed(OrdersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}