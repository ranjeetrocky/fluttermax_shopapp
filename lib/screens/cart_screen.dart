import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<Cart>(
          builder: (context, cart, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Card(
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total', style: TextStyle(fontSize: 20)),
                        const Spacer(),
                        Chip(
                          label: Text('\$ ${cart.totalAmount}'),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: const Text('ORDER NOW'))
              ],
            );
          },
        ),
      ),
    );
  }
}
