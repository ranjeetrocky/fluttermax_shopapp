import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/cart.dart';
import 'package:fluttermax_state_management_shopapp/screens/cart_screen.dart';
import 'package:fluttermax_state_management_shopapp/widgets/app_drawer.dart';
import 'package:fluttermax_state_management_shopapp/widgets/badge.dart';
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
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("My Shop"),
        actions: [
          Consumer<Cart>(
            builder: (_, cartProvider, child) {
              return Badge(
                color: Theme.of(context).colorScheme.secondaryContainer,
                value: cartProvider.cartItemsCount,
                child: child as Widget,
              );
            },
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
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
          ),
        ],
      ),
      body: ProductsGridView(showOnlyFavorites: _showOnlyFavorite),
    );
  }
}
