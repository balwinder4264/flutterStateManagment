import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stateManagement/providers/test.dart';

class Test extends StatelessWidget {
  static const routeName = "/test";
  @override
  Widget build(BuildContext context) {
    final testData = Provider.of<Test_Provider>(context);
    // final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Center(
        child: Text(
          testData.items["id"].toString(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              title: Text('category')),
          BottomNavigationBarItem(
            
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              title: Text('Favorite'))
        ],
      ),
    );
  }
}
