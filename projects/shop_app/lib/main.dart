import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/auth_provider.dart';
import 'package:shop_app/domain/providers/cart_provider.dart';
import 'package:shop_app/domain/providers/orders_provider.dart';
import 'package:shop_app/domain/providers/products_provider.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider.create should be used whenever a new instance 
    // of an object is passed
    return MultiProvider(
      providers: [
        // All listening children will have the same instance of ProductsProvider
        // So any change done to this class will rebuild again those children
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme
            .fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: Colors.amber),
        ),
        routes: {
          '/':(context) => const AuthScreen(),
          ProductsOverviewScreen.routeName: (context) => const ProductsOverviewScreen(),
          ProductDetailScreen.routeName:(context) => const ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          UserProductScreen.routeName:(context) => const UserProductScreen(),
          EditProductScreen.routeName:(context) => const EditProductScreen(),
        },
      ),
    );
  }
}

