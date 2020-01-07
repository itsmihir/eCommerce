import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/user_product_item.dart';
import '../providers/products.dart';
import '../widgets/order_drawer.dart';
import '../screens/edit_product_screen.dart';

class UsersProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  Future<void> _refreshProducts(BuildContext context) async{
    Provider.of<Products>(context,listen: false).fetchAndSetProducts();
  }
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh:()=> _refreshProducts(context),
              child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (_, i) => Column(
              children: <Widget>[
                UserProductItem(
                  productData.items[i].id,
                    productData.items[i].imageUrl, productData.items[i].title),
             
             Divider(),
              ], 
            ),
          ),
        ),
      ),
    );
  }
}
