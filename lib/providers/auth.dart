import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttermax_state_management_shopapp/models/consts.dart';
import 'package:fluttermax_state_management_shopapp/models/http_exeption.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      kprint('userData not saved on device');
      return false;
    }
    try {
      final userData = prefs.getString('userData');
      final extractedUserData = json.decode(userData!) as Map<String, dynamic>;

      final expiryDate =
          DateTime.parse(extractedUserData['expiryDate'].toString());
      kprint('autoLoginData : $userData');
      if (expiryDate.isBefore(DateTime.now())) {
        return false;
      }

      _token = extractedUserData['token'].toString();
      _userId = extractedUserData['userId'].toString();
      _expiryDate = expiryDate;
      notifyListeners();
      autoLogOut();
      return true;
    } catch (error) {
      print("error : " + error.toString());
    }
    return false;
  }

  Future<void> _authenticate(
      {required String email,
      required String password,
      required String urlSegment}) async {
    final authUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=${Consts.apiKey}';
    final Uri authUri = Uri.parse(authUrl);
    final postBody = json.encode({
      "email": email,
      "password": password,
      "returnSecureToken": true,
    });
    kprint(authUrl + "\n" + postBody);
    try {
      final response = await http.post(authUri, body: postBody);
      // kprint(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        kprint(responseData['error']['message']);
        throw HttpExeption(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      autoLogOut();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate?.toIso8601String()
      });
      prefs.setString('userData', userData);

      kprint('authenticated user data : ' + prefs.getString('userData')!);
    } catch (e) {
      kprintError(e);
      rethrow;
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    return _authenticate(
        email: email, password: password, urlSegment: 'signInWithPassword');
  }

  Future<void> signUp({required String email, required String password}) async {
    return _authenticate(
        email: email, password: password, urlSegment: 'signUp');
  }

  Future<void> logOut() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
    } else {}
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    kprint('Loggedout');
    notifyListeners();
  }

  void autoLogOut() {
    final timeToExpiry = _expiryDate?.difference(DateTime.now()).inSeconds;
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    _authTimer = Timer(
      Duration(seconds: timeToExpiry ?? 3600),
      logOut,
    );
  }
}
