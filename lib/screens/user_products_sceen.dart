import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/products.dart';
import 'package:fluttermax_state_management_shopapp/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routName = '/userProductscreen';
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (_, index) {
            final product = productsProvider.items[index];
            return UserProductItemWidget(
              title: product.title,
              imageUrl: product.imageUrl,
            );
          },
          itemCount: productsProvider.items.length,
        ),
      ),
    );
  }
}
