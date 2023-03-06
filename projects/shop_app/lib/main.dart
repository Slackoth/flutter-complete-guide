import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/products_provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // All listening children will have the same instance of ProductsProvider
      // So any change done to this class will rebuild again those children
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme
            .fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: Colors.amber),
        ),
        routes: {
          ProductsOverviewScreen.routeName: (context) => const ProductsOverviewScreen(),
          ProductDetailScreen.routeName:(context) => const ProductDetailScreen()
        },
      ),
    );
  }
}

