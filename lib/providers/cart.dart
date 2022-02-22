import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};
  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get cartItemsCount {
    return _cartItems.length; //for total items
    // var total = 0;
    // _cartItems.forEach((key, cartItem) {
    //   total += cartItem.quantity;
    // });
    // return total; //for total quantity of items
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addCartItem({
    required String productId,
    required String title,
    required double price,
  }) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            quantity: 1,
            price: price),
      );
    }
    notifyListeners();
  }

  void removeItem(productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }
}

class CartItem {
  final String title, id;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}
