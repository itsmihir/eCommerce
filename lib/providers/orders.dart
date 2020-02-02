import 'package:flutter/foundation.dart';
import './cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datetime;

  OrderItem({this.id, this.datetime, this.amount, this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken,this.userId,this._orders );

  List<OrderItem> get orderData {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://fir-b45e5.firebaseio.com/orders.json?auth=$authToken';
    var timestamp = DateTime.now();
    try {
      var res = await http.post(url,
          body: json.encode({
            'amount': total,
            'datetime': timestamp.toString(),
            'userId':userId,
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                      
                    })
                .toList(),
          }));
      _orders.insert(
          0,
          OrderItem(
              id: json.decode(res.body)['name'],
              amount: total,
              datetime: timestamp,
              products: cartProducts));
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchAndsetOrders() async {
    final url = 'https://fir-b45e5.firebaseio.com/orders.json?auth=$authToken&orderBy="userId"&equalTo="$userId"';
    List<OrderItem> loadedOrders = [];
    try {
      final res = await http.get(url);
      final eData = json.decode(res.body) as Map<String, dynamic>;
      if(eData==null)
      {
        return;
      }
      eData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
          id: orderId,
          datetime: DateTime.parse(orderData['datetime']),
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
                id: item['id'],
                price: item['price'],
                quantity: item['quantity'],
                title: item['title']);
          }).toList(),
        ));
      });
      _orders = loadedOrders;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
