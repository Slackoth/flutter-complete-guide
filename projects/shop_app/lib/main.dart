import 'package:flutter/material.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme
          .fromSwatch(primarySwatch: Colors.deepPurple)
          .copyWith(secondary: Colors.amber),
      ),
      home: ProductsOverviewScreen(),
    );
  }
}

