import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/consts.dart';
import '../models/http_exeption.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  // Products() {
  //   fetchAndSetProducts();
  // }
  final List<Product> _items;
  final String _authToken;
  final String _userId;

  Products(this._authToken, this._items, this._userId);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
    // ? [..._items.where((item) => item.isFavurite).toList()] //no need to do this cause where method gives new list
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? '&orderBy="creatorId"&equalTo="$_userId"' : '';
    Uri productsUri =
        Uri.parse(Consts.productsUrl + '?auth=$_authToken$filterString');
    final response = await http.get(productsUri);
    var productData = json.decode(response.body);
    if (productData == null) {
      throw HttpExeption('no product available ');
    }
    final favoriteResponse = await http.get(
      Uri.parse(Consts.kFirebaseDatabaseUrl +
          'users/$_userId/userFavorites.json?auth=$_authToken'),
    );
    final favoriteData = json.decode(favoriteResponse.body);

    productData = productData as Map<String, dynamic>;
    _items.clear();
    kprint("Updating Products");
    productData.forEach((productId, productData) {
      _items.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: double.parse(productData['price'].toString()),
          imageUrl: productData['imageUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[productId] ?? false));
    });
    kprint(_items.length);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    Uri productsUri = Uri.parse(Consts.productsUrl + '?auth=$_authToken');
    var newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    try {
      final response = await http.post(productsUri,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
            'creatorId': _userId,
          }));
      _items.insert(
          0,
          newProduct = Product(
            id: json.decode(response.body)['name'],
            title: product.title,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl,
          ));
      notifyListeners();
    } catch (error) {
      kprint(error);
      rethrow;
    }
  }

  Future<void> updateproduct(String id, Product newPoduct) async {
    final uri = Uri.parse(
        Consts.kFirebaseDatabaseUrl + 'products/$id.json?auth=$_authToken');
    try {
      final response = await http.patch(uri,
          body: json.encode({
            'title': newPoduct.title,
            'price': newPoduct.price,
            'description': newPoduct.description,
            'imageUrl': newPoduct.imageUrl
          }));
      kprint(_authToken);
      kprint(json.decode(response.body));
      final productIndex = _items.indexWhere((product) => product.id == id);
      if (productIndex >= 0) {
        _items[productIndex] = newPoduct;
      } else {
        kprint('...');
      }
      notifyListeners();
    } catch (error) {
      kprint(error);
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    final uri = Uri.parse(
        Consts.kFirebaseDatabaseUrl + 'products/$id.json?auth=$_authToken');
    final existingProductIndex =
        _items.indexWhere((product) => product.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    try {
      final response = await http.delete(uri);
      if (response.statusCode != 200) {
        throw HttpExeption('Could not Delete');
      }
    } catch (error) {
      kprint(error);
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw Exception(error);
    }
    existingProduct = null;
  }
}
