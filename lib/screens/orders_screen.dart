import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/order_drawer.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart' as ord;
class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.orderData.length,
        itemBuilder: (context,i){
          return ord.OrderItem(orders.orderData[i]);
        },
      ),
      drawer: AppDrawer(),
    );
  }
}