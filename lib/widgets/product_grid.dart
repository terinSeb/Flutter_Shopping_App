import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFav;
  const ProductGrid({Key? key, required this.showFav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsDate = Provider.of<Products>(context);
    final products = showFav ? productsDate.favoriteItems : productsDate.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: const ProductItem(),
            ));
  }
}
