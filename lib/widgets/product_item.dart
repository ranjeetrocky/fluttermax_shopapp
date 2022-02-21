import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/consts.dart';
import '../screens/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import 'blurrycontainer.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
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
              child: BlurryContainer(
                borderRadius: BorderRadius.circular(20),
                blur: Consts.kBlur,
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(
                      product.isFavourite
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      color: Colors.redAccent,
                    ),
                    onPressed: () => product.toggleFavouriteValue(),
                  ),
                ),
              ),
            )),
            footer: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: Consts.kBlur, sigmaY: Consts.kBlur),
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
