import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/main_drawer.dart';
import 'package:shop_app/widgets/user_products/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});

  static const String routeName = '/users-products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
          }, icon: const Icon(Icons.add))
        ],
      ),
      drawer: const MainDrawer(),
      body: Consumer<ProductsProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: value.products.length,
            itemBuilder: (context, index) {
              return Column(children: [
                UserProductItem(
                  title: value.products[index].title, 
                  imageUrl: value.products[index].imageUrl
                ),
                const Divider()
              ],);
            }
          ),
        ),
      ),
    );
  }
}