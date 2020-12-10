import 'package:flutter/material.dart';
import '../screens/edit_products_screen.dart';

class UserProductItem extends StatelessWidget {
  final items;
  final Function delteProduct;
  // final String imageUrl;
  UserProductItem(this.items, this.delteProduct);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(items.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(items.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                    arguments: items.id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                delteProduct(items.id, context);
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
