import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/orders.dart'
    as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;
  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(children: [
        ListTile(
          title: Text('\$${order.amount}'),
          subtitle: Text(
            DateFormat('dd MM yyyy').format(order.dateTime),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.expand_more_rounded),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}
