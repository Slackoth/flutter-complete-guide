import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/product_provider.dart';
import 'package:shop_app/domain/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';

  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)?.settings.arguments as String;
    final ProductProvider product = Provider.of<ProductsProvider>(
      context,
      listen: false // When data changes, this widget will not be rebuild
    ).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}