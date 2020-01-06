import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../providers/cart.dart';
import '../widgets/order_drawer.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoritesOnly = false;
  var _isLoading = true;
//  var _isInit = true;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Products>(context,listen: false).fetchAndSetProducts().then((_){
          setState(() {
        _isLoading = false;
            
          });
      });
    });
    super.initState();
  }

  // void didChangedependencies() {
  //   if(_isInit)
  //   Provider.of<Products>(context).fetchAndSetProducts();
  //   print(1);
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selected) {
              setState(() {
                if (selected == FilterOptions.Favorites) {
                  _showFavoritesOnly = true;
                } else {
                  if (selected == FilterOptions.All) {
                    _showFavoritesOnly = false;
                  }
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.All,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: _isLoading? Center(child: CircularProgressIndicator(),):ProductsGrid(_showFavoritesOnly),
      drawer: AppDrawer(),
    );
  }
}
