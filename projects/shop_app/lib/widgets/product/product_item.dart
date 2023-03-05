import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../domain/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(product.imageUrl)
    );
  }
}