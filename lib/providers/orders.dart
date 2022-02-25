import 'dart:convert';

import 'package:flutter/material.dart';
import '../providers/cart.dart';
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
  List<OrderItem> _orderItems = [];
  List<OrderItem> get orderItems {
    return _orderItems;
  }

  final String _authToken;

  Orders(this._authToken, this._orderItems) {
    kprint(_authToken);
  }

  Future<void> fetchAndSet() async {
    Uri ordersUri = Uri.parse(Consts.ordersUrl + "?auth=$_authToken");
    try {
      final response = await http.get(ordersUri);
      var data = json.decode(response.body);
      kprint(data);
      if (data != null) {
        _orderItems.clear();
        data = data as Map<String, dynamic>;
        data.forEach((orderId, orderData) {
          _orderItems.add(
            OrderItem(
                id: orderId,
                amount: orderData['amount'],
                products: (orderData['products'] as List<dynamic>)
                    .map((product) => CartItem(
                        id: product['id'],
                        title: product['title'],
                        quantity: product['quantity'],
                        price: product['price']))
                    .toList(),
                dateTime: DateTime.parse(orderData['dateTime'])),
          );
        });
        _orderItems = _orderItems.reversed.toList();
        notifyListeners();
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> addOrder(List<CartItem> cartproducts, double total) async {
    final timestamp = DateTime.now();
    Uri ordersUri = Uri.parse(Consts.ordersUrl + "?auth=$_authToken");
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
