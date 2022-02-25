import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/products.dart';
import 'package:fluttermax_state_management_shopapp/screens/edit_product_sceen.dart';
import 'package:fluttermax_state_management_shopapp/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

import '../models/consts.dart';
import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routName = '/userProductscreen';
  const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsProvider = Provider.of<Products>(context);
    kprint('rebuilding ...');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: const Icon(Icons.add_rounded),
          )
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : RefreshIndicator(
                  onRefresh: () => _refreshProducts(context),
                  child: Consumer<Products>(
                    builder: (context, productsProvider, _) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                        itemBuilder: (_, index) {
                          productsProvider = productsProvider;
                          final product = productsProvider.items[index];
                          return UserProductItemWidget(
                            product: product,
                          );
                        },
                        itemCount: productsProvider.items.length,
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
