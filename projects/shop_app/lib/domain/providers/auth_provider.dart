import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop_app/domain/exceptions/http/http_exception.dart';

class AuthProvider with ChangeNotifier {
  static const apiKey = 'AIzaSyBEJJb_ZzktMW4EyXNzlzo-OSkPQunSAX4';
  
  String? _token;
  DateTime? _expireDate;
  String? _userId;

  bool get isAuthenticated {
    return token != null;
  }

  String? get token {
    if(
      _expireDate != null 
      && _expireDate!.isAfter(DateTime.now())
      && _token != null
    ) {
      return _token!;
    }

    return null;
  }

  Future<void> signUp(String email, String password) async {
    try {
      final Uri url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');
      final http.Response response = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      }));
      final data = json.decode(response.body);
      
      if(data['error'] != null) {
        throw HttpException(data['error']['message']);
      }

      _token = data['idToken'];
      _userId = data['localId'];
      _expireDate = DateTime.now().add(Duration(seconds: int.tryParse(data['expiresIn']) ?? 60 * 30));
      notifyListeners();
    } catch (error) { rethrow; }
  }

  Future<void> login(String email, String password) async {
    try {
      final Uri url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey');
      final http.Response response = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      }));
      final data = json.decode(response.body);
      
      if(data['error'] != null) {
        throw HttpException(data['error']['message']);
      }

      _token = data['idToken'];
      _userId = data['localId'];
      _expireDate = DateTime.now().add(Duration(seconds: int.tryParse(data['expiresIn']) ?? 60 * 30));
      notifyListeners();
    } catch (error) { rethrow; }
  }
}