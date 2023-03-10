import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({super.key, required this.title, required this.imageUrl, required this.id, required this.deleteProduct});

  final String id;
  final String title;
  final String imageUrl;
  final Function deleteProduct;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ScaffoldMessengerState messanger = ScaffoldMessenger.of(context);

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl)
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
            },
            color: theme.colorScheme.primary,
            icon: const Icon(Icons.edit)),
          IconButton(
            onPressed: () async {
              try {
                await deleteProduct();
              } catch (error) {
                messanger.showSnackBar(const SnackBar(content: Text('Deleting failed')));
              }
            },
            color: theme.colorScheme.error,
            icon: const Icon(Icons.delete))
        ]),
      ),
    );
  }
}