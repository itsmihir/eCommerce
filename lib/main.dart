import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/screens/auth-screen.dart';
import 'package:shop/screens/user_product_screen.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/orders.dart';
import './screens/product_overview_screen.dart';
import './screens/orders_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
              update: (ctx, auth, previousProducts) => Products(
                    auth.token,
                    auth.userId,
                    previousProducts == null ? [] : previousProducts.items,
                  ),
              create: (ctx) => Products(null, null, [])),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
              update: (ctx, auth, previousOrders) => Orders(
                    auth.token,
                    auth.userId,
                    previousOrders == null ? [] : previousOrders.orderData,
                  ),
              create: (ctx) => Orders(null, null, [])),
        ],

        // create: (context) => Products(),
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'MyShop',
                  theme: ThemeData(
                    primaryColor: Colors.purple,
                    accentColor: Colors.deepOrange,
                    fontFamily: 'Lato',
                  ),
                  home: auth.isAuth
                      ? ProductOverviewScreen()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (ctx, authResult) =>
                              authResult.connectionState ==
                              ConnectionState.waiting
                        
                          ? SplashScreen()
                          : AuthScreen(),
                      ),
                  routes: {
                    ProductDetailScreen.routeName: (ctx) =>
                        ProductDetailScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                    OrdersScreen.routeName: (ctx) => OrdersScreen(),
                    UsersProductsScreen.routeName: (ctx) =>
                        UsersProductsScreen(),
                    EditProductScreen.routeName: (ctx) => EditProductScreen(),
                  },
                )));
  }
}
