import 'package:flutter/material.dart';

import '../widgets/product_grid.dart';

enum FilterOptions {
// ignore: constant_identifier_names
  Favorites,
// ignore: constant_identifier_names
  All
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  // ignore: unused_field
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: ((_) => [
                    const PopupMenuItem(
                      value: FilterOptions.Favorites,
                      child: Text('Only Favorites'),
                    ),
                    const PopupMenuItem(
                      value: FilterOptions.All,
                      child: Text('Show all'),
                    )
                  ]))
        ],
      ),
      body: ProductGrid(
        showFav: _showOnlyFavorites,
      ),
    );
  }
}
