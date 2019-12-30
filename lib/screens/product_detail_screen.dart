import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import '../providers/products.dart';
class ProductDetailScreen extends StatelessWidget {
  static String routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final id =  ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =  Provider.of<Products>(context , listen: false).findById(id);        // i do not want this widget to change when some new data is
    return Scaffold(                                                                          // being added so it listen: false
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}