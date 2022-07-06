import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURl;
  const ProductItem(
      {Key? key, required this.id, required this.title, required this.imageURl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          trailing: IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
          title: Text(
            title,
            textAlign: TextAlign.center,
          )),
      child: Image.network(
        imageURl,
        fit: BoxFit.cover,
      ),
    );
  }
}
