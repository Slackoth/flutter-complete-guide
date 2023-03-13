import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  static const apiKey = 'AIzaSyBEJJb_ZzktMW4EyXNzlzo-OSkPQunSAX4';
  
  late String _token;
  late DateTime _expireDate;
  late String _userId;

  Future<void> signUp(String email, String password) async {
    final Uri url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');
    final http.Response response = await http.post(url, body: json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true
    }));
  }

  Future<void> login(String email, String password) async {
    final Uri url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey');
    final http.Response response = await http.post(url, body: json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true
    }));
  }
}