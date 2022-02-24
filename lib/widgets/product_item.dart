import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/cart.dart';
import 'package:fluttermax_state_management_shopapp/widgets/ripple_circle_avatar.dart';
import '../models/consts.dart';
import '../screens/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import 'blurrycontainer.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              product: product,
            ),
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
                          value: imageChunkEvent.expectedTotalBytes != null
                              ? imageChunkEvent.cumulativeBytesLoaded /
                                  imageChunkEvent.expectedTotalBytes!
                              : null,
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
                    child: Consumer<Product>(
                      builder: (context, currentProduct, _) => IconButton(
                        icon: Icon(
                          currentProduct.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          color: Colors.redAccent,
                        ),
                        onPressed: () async {
                          try {
                            await currentProduct.toggleFavouriteValue();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              currentProduct.isFavorite
                                  ? 'Added to Favorites'
                                  : 'Removed from Favorites',
                              textAlign: TextAlign.center,
                            )));
                          } catch (e) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              currentProduct.isFavorite
                                  ? "Could not remove from Favorites"
                                  : 'Could not add to Favorites',
                              textAlign: TextAlign.center,
                            )));
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            footer: BlurryContainer(
              blur: Consts.kBlur,
              child: GridTileBar(
                backgroundColor: Colors.black54,
                trailing: RippleCircleAvatar(
                  child: IconButton(
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                    onPressed: () {
                      cart.addCartItem(
                          productId: product.id,
                          title: product.title,
                          price: product.price);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("Added to Cart"),
                        action: SnackBarAction(
                            label: "UNDO",
                            onPressed: () {
                              cart.removeSingleItem(product.id);
                            }),
                      ));
                    },
                  ),
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
    );
  }
}
