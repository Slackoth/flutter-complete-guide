import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({super.key, required this.title, required this.imageUrl});

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl)
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {},
            color: theme.colorScheme.primary,
            icon: const Icon(Icons.edit)),
          IconButton(
            onPressed: () {},
            color: theme.colorScheme.error,
            icon: const Icon(Icons.delete))
        ]),
      ),
    );
  }
}