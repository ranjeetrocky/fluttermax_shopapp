import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/orders.dart'
    as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    double horizontalMargin = _isExpanded ? 0.0 : 16.0;
    return Card(
      margin: EdgeInsets.only(
          top: 16, right: horizontalMargin, left: horizontalMargin),
      child: Column(children: [
        ListTile(
          title: Text('\$${widget.order.amount}'),
          subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
          ),
          trailing: IconButton(
            icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more_rounded),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isExpanded
              ? min(widget.order.products.length * 30 + 10, 100)
              : 0,
          child: ListView(
            children: widget.order.products
                .map((product) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${product.quantity}x \$${product.price}',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ]),
    );
  }
}
