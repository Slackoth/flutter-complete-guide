import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/main_drawer.dart';
import 'package:shop_app/widgets/user_products/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});

  static const String routeName = '/users-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
  }

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
        builder: (context, value, child) => RefreshIndicator(
          onRefresh: () { return _refreshProducts(context); },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: value.products.length,
              itemBuilder: (context, index) {
                return Column(children: [
                  UserProductItem(
                    id: value.products[index].id,
                    title: value.products[index].title, 
                    imageUrl: value.products[index].imageUrl,
                    deleteProduct: () => value.deleteProduct(value.products[index].id)
                  ),
                  const Divider()
                ],);
              }
            ),
          ),
        ),
      ),
    );
  }
}