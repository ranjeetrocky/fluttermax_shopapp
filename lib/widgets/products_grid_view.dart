import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/products.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) =>
          ProductItem(product: productsProvider.items[index]),
      itemCount: productsProvider.items.length,
    );
  }
}
