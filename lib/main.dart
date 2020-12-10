import 'package:flutter/material.dart';
import 'package:stateManagement/providers/orders.dart';
import 'package:stateManagement/screens/cart_screen.dart';
import 'package:stateManagement/screens/edit_products_screen.dart';
import 'package:stateManagement/screens/test.dart';
import './screens/products_overview_screen.dart';
import './screens/products_details_screen.dart';
import 'package:provider/provider.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/test.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Test_Provider(),
        )
      ],
      child: MaterialApp(
          title: 'State Management',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'),
          home: ProductOverViewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            Test.routeName: (ctx) => Test()
          }),
    );
  }
}
