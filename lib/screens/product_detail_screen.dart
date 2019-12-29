import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static String routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final id =  ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(id),
      ),
    );
  }
}