import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});
  void _setFavStatus(bool oldStatus) {
    isFavorite = oldStatus;
    notifyListeners();
  }

  Future<void> toogleFavorite(String? authToken, String userId) async {
    final oldStatus = isFavorite;
    try {
      isFavorite = !isFavorite;
      notifyListeners();
      final url = Uri.parse(
          'https://fluttershoppingapp-9b02a-default-rtdb.firebaseio.com/userFavorite/$userId/$id.json?auth=$authToken');
      final response = await http.put(url,
          body: json.encode(
            isFavorite,
          ));
      if (response.statusCode >= 400) {
        _setFavStatus(oldStatus);
      }
    } catch (error) {
      _setFavStatus(oldStatus);
    }
  }
}
