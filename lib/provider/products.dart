import 'package:flutter/widgets.dart';
import '../lib/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items{
    return [..._items];
  }

}