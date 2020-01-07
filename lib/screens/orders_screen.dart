import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/order_drawer.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart' as ord;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  // void initState() {
  //   Future.delayed(Duration.zero).then((_) async {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await Provider.of<Orders>(context, listen: false).fetchAndsetOrders();
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
   // final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndsetOrders(),
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapShot.error == null) {
              return Consumer<Orders>(
                builder: (ctx,orderData,child)=>ListView.builder(
                  itemCount: orderData.orderData.length,
                  itemBuilder: (context, i) {
                    return ord.OrderItem(orderData.orderData[i]);
                  },
                )
              );
            } else {
              return Text('An error');
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
