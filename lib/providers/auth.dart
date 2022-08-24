import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  // ignore: unused_field
  late String _token;
  // ignore: unused_field
  late DateTime _expiryDate;
  // ignore: unused_field
  late String _userId;

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB01w99Ydp0tV2qLXFItFKVyR3W8AAhxgU');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    // ignore: avoid_print
    print(json.decode(response.body));
  }
}