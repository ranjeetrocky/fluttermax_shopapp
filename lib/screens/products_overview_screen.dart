import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/cart.dart';
import 'package:fluttermax_state_management_shopapp/providers/products.dart';
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
  bool _isInitialized = false;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<Products>(context).fetchAndSetProducts(); //method 1 :Gives Error
    // Future.delayed(Duration.zero).then((value) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // }); //method 2 :runs after Build methos is first called & wont give error
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isLoading = true;
      _initializeData();
    } //method 3 :not better than 2nd method
    _isInitialized = true;
  }

  void _initializeData() async {
    Provider.of<Products>(context).fetchAndSetProducts().catchError(
      (error) {
        return showDialog<Null>(
          context: context,
          builder: (bctx) => AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(bctx).pop();
                  },
                  child: const Text('Okay'))
            ],
            content: const Text('Something went wrong...'),
            title: const Text('An error occured'),
          ),
        );
      },
    ).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ProductsGridView(showOnlyFavorites: _showOnlyFavorite),
    );
  }
}
