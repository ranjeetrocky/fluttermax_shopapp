import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid_view.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedOption) {
              setState(() {
                selectedOption == FilterOptions.favorites
                    ? _showOnlyFavorite = true
                    : _showOnlyFavorite = false;
              });
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
      body: ProductsGridView(showOnlyFavorites: _showOnlyFavorite),
    );
  }
}
