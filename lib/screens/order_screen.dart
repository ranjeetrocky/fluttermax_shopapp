import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/orders.dart'
    show Orders;
import 'package:fluttermax_state_management_shopapp/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrderItem(order: orders.orderItems[index]);
        },
        itemCount: orders.orderItems.length,
      ),
    );
  }
}
