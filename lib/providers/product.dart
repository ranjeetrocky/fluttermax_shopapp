import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id, title, description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });
}
