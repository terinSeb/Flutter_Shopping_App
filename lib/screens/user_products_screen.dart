import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/providers/products.dart';
import 'package:shopping_app_flutter/screens/edit_product_screen.dart';
import 'package:shopping_app_flutter/widgets/app_drawer.dart';
import 'package:shopping_app_flutter/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              }),
              icon: const Icon(Icons.add)),
        ],
      ),
      drawer: const AppDrwaer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (ctx, i) => Column(
                  children: [
                    UserProductItem(
                        title: productsData.items[i].title,
                        imageUrl: productsData.items[i].imageUrl),
                    const Divider()
                  ],
                )),
      ),
    );
  }
}
