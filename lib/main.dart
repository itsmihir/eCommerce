import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/user_product_screen.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './providers/products.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/edit_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Products(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProvider.value(
            value: Orders(),
          )
        ],

        // create: (context) => Products(),
        child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primaryColor: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: ProductOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName:(ctx) => CartScreen(),
            OrdersScreen.routeName : (ctx) =>OrdersScreen(),
            UsersProductsScreen.routeName:(ctx) => UsersProductsScreen(),
            EditProductScreen.routeName:(ctx)=> EditProductScreen(),
          },
        ));
  }
}
