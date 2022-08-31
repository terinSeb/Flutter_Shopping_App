// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app_flutter/models/http_exception.dart';

class Auth with ChangeNotifier {
  // ignore: unused_field
  late String? _token;
  // ignore: unused_field
  DateTime? _expiryDate = DateTime.now();
  // ignore: unused_field
  late String? _userId;
  Timer? _authTimer;
  bool get isAuth {
    return token != null;
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

  Future<void> _authenticate(
      String? email, String? password, String? urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyB01w99Ydp0tV2qLXFItFKVyR3W8AAhxgU');
    try {
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
      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["message"]);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      notifyListeners();
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<void> signup(String? email, String? password, String? authData) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String? email, String? password, String? authData) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logOut() {
    _userId = null;
    _token = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    var timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    // timeToExpiry = 3;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logOut);
  }
}
