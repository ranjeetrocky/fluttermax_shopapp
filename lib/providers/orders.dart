import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/cart.dart';

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

  void addOrder(List<CartItem> cartproducts, double total) {
    _orderItems.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartproducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void removeItem(String productId) {
    _orderItems.remove(productId);
    notifyListeners();
  }

  void clear() {
    _orderItems.clear();
    notifyListeners();
  }
}
