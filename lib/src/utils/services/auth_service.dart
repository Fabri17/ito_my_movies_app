import 'package:flutter/material.dart';
import 'package:my_movies_app/src/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AuthService {
  String baseUrl = Apis.authApi;

  Future<String> authUser(String email, String password) async {
    var url = Uri.https(baseUrl, '/api/login');
    var response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return json['token'];
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }

    return "";
  }
}

AuthService authService = AuthService();
