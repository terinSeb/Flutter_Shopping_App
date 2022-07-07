import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURl;
  const ProductItem(
      {Key? key, required this.id, required this.title, required this.imageURl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {},
                icon: const Icon(Icons.favorite)),
            trailing: IconButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart)),
            title: Text(
              title,
              textAlign: TextAlign.center,
            )),
        child: GestureDetector(
          onTap: (() {
            Navigator.of(context)
                .pushNamed(ProductDetailScreen.routeName, arguments: id);
          }),
          child: Image.network(
            imageURl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
