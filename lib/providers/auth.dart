import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttermax_state_management_shopapp/models/consts.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signUp({required String email, required String password}) async {
    Uri authUri = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${Consts.apiKey}');
    try {
      final response = await http.post(authUri,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    Uri authUri = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${Consts.apiKey}');
    try {
      final response = await http.post(authUri,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
