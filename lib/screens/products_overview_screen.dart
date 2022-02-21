import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid_view.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedOption) {
              switch (selectedOption) {
                case FilterOptions.favorites:
                  productsContainer.showFavoriteOnly();
                  break;
                case FilterOptions.all:
                  productsContainer.showAll();
                  break;
                default:
                  {}
                  break;
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                  value: FilterOptions.favorites,
                  child: Text("Only Favorites")),
              const PopupMenuItem(
                  value: FilterOptions.all, child: Text("Show All")),
            ],
          )
        ],
      ),
      body: const ProductsGridView(),
    );
  }
}
