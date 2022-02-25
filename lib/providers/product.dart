import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttermax_state_management_shopapp/models/consts.dart';
import 'package:fluttermax_state_management_shopapp/models/http_exeption.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id, title, description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
  Future<void> toggleFavouriteValue(String authToken, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !oldStatus;

    notifyListeners();
    try {
      final response = await http.put(
          Uri.parse(Consts.kFirebaseDatabaseUrl +
              'users/$userId/userFavorites/$id.json?auth=$authToken'),
          body: json.encode(!oldStatus));
      final responsedata = json.decode(response.body);
      print(response.statusCode);
      print(responsedata);
      if (response.statusCode != 200) {
        throw HttpExeption(oldStatus
            ? "Could not remove product from Favorites"
            : "Couldn't add to Favorites");
      }
    } catch (e) {
      isFavorite = oldStatus;
      notifyListeners();
      throw Exception('Could not Delete');
    }
  }
}
