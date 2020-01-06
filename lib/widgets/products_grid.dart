import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool _showOnlyFavorites;

  ProductsGrid(this._showOnlyFavorites);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final product = _showOnlyFavorites ? productsData.favoritesItems: productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: product.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
       value: product[i],
       // create: (context) => product[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
