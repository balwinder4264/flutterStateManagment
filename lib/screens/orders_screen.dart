import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer_widget.dart';
import '../widgets/orders_items_widget.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    // print(orderData.orders);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, i) => OrderItems(orderData.orders[i])),
    );
  }
}
