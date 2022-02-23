import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/screens/order_screen.dart';
import 'package:fluttermax_state_management_shopapp/screens/user_products_sceen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text('Hello'),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.payment_rounded),
          title: const Text('Orders'),
          onTap: () {
            Navigator.of(context).pushNamed(OrderScreen.routeName);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.list_rounded),
          title: const Text('Manage Products'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(UserProductsScreen.routName);
          },
        ),
      ]),
    );
  }
}