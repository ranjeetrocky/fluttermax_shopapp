import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/orders.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
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
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total', style: TextStyle(fontSize: 20)),
                        const Spacer(),
                        Chip(
                          label:
                              Text('\$ ${cart.totalAmount.toStringAsFixed(2)}'),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return CartItem(
                        cartItem: cart.cartItems.values.toList()[index],
                        productId: cart.cartItems.keys.toList()[index],
                      );
                    },
                    itemCount: cart.cartItems.length,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<Orders>(context, listen: false).addOrder(
                        cart.cartItems.values.toList(), cart.totalAmount);
                    cart.clear();
                  },
                  child: const Text('ORDER NOW'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
