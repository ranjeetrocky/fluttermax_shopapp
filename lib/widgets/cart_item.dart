import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/cart.dart' as ci;

class CartItem extends StatelessWidget {
  final ci.CartItem cartItem;
  const CartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          cartItem.title,
        ),
        trailing: Text(
          'Total: \$ ${cartItem.price * cartItem.quantity}',
        ),
        subtitle: Text('${cartItem.quantity} x ${cartItem.price}'),
      ),
    );
  }
}
