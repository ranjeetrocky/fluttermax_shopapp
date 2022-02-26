import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';

class ProductsGridView extends StatelessWidget {
  final bool showOnlyFavorites;

  const ProductsGridView({
    Key? key,
    required this.showOnlyFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final productsProvider = Provider.of<Products>(context);
    final products = showOnlyFavorites
        ? productsProvider.favoriteItems
        : productsProvider.items;
    return GridView.builder(
      // physics: const BouncingScrollPhysics(),//commented to enable refresh indicator
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: mq.size.width < 1134
            ? mq.size.width < 756
                ? 2
                : 3
            : 4,
        childAspectRatio: 3 / 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ChangeNotifierProvider.value(
            value: product, child: ProductItem(key: ValueKey(products[index])));
      },
    );
  }
}
