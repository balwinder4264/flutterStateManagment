import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:stateManagement/providers/products_provider.dart';
import 'package:stateManagement/screens/edit_products_screen.dart';
import '../widgets/user_product_items.dart';
import '../widgets/app_drawer_widget.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/user-products";
  void _deleteProduct(id, ctx) {
    print(id);
    Provider.of<Products>(ctx, listen: false).deleteProducts(id);
    // print(id);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(productsData.items[i], _deleteProduct),
              Divider()
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
