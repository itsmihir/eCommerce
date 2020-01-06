import 'package:flutter/material.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:Column(children: <Widget>[
          AppBar(
            title: Text('Hello '),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(leading: Icon(Icons.shop),title: Text('Shop'),
          onTap: (){
            Navigator.of(context).pushReplacementNamed('/');
          },
          ),
          ListTile(leading: Icon(Icons.shop),title: Text('orders'),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          },
          ),
          ListTile(leading: Icon(Icons.shop),title: Text('My Products'),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(UsersProductsScreen.routeName);
          },
          ),
        ],)
    );
  }
}