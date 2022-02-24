import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/cart.dart';
import 'package:http/http.dart' as http;

import '../models/consts.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orderItems = [];
  List<OrderItem> get orderItems {
    return _orderItems;
  }

  Uri ordersUri = Uri(
    scheme: 'https',
    host: Consts.kFirebaseDatabaseHost,
    path: 'orders.json',
  );

  Future<void> addOrder(List<CartItem> cartproducts, double total) async {
    final timestamp = DateTime.now();
    try {
      final response = await http.post(ordersUri,
          body: json.encode({
            'amount': total,
            'products': cartproducts
                .map((cartItem) => {
                      'id': cartItem.id,
                      'title': cartItem.title,
                      'price': cartItem.price,
                      'quantity': cartItem.quantity,
                    })
                .toList(),
            'dateTime': timestamp.toIso8601String(),
          }));
      _orderItems.insert(
        0,
        OrderItem(
          id: jsonDecode(response.body)['name'],
          amount: total,
          products: cartproducts,
          dateTime: timestamp,
        ),
      );
      notifyListeners();
    } catch (e) {
      // _orderItems.removeAt(0);
      notifyListeners();
      throw Exception('Couldn\'t add order');
    }
  }
}
