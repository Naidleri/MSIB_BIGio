import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/character.dart';

class FavoriteService {
  static const String baseUrl = 'http://10.0.2.2:8080';

  Future<List<Character>> getFavorites() async {
    final response = await http.get(Uri.parse('$baseUrl/favorite'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  Future<void> addFavorite(Character character) async {
    final response = await http.post(
      Uri.parse('$baseUrl/favorite'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(character.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add favorite');
    }
  }

  Future<void> removeFavorite(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/favorite/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to remove favorite');
    }
  }
}
