import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/screens/product_details_screen.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(id: product.id),
          ));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: GridTile(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, imageChunkEvent) {
                return imageChunkEvent == null
                    ? child
                    : Center(
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 1,
                          semanticsLabel: "Loading",
                          value: (imageChunkEvent.cumulativeBytesLoaded /
                              imageChunkEvent.expectedTotalBytes!),
                        ),
                      );
              },
            ),
            header: GridTileBar(
                leading: CircleAvatar(
              backgroundColor: Colors.black26,
              child: IconButton(
                icon: const Icon(
                  Icons.favorite_outline_rounded,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            )),
            footer: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: GridTileBar(
                  backgroundColor: Colors.black54,
                  trailing: IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {},
                  ),
                  title: Text(
                    product.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
