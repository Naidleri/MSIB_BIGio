import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/character.dart';

class RickAndMortyApi {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$baseUrl/character'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      return data.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<Character> fetchCharacterById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/character/$id'));
    if (response.statusCode == 200) {
      return Character.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load character details');
    }
  }

  Future<List<Character>> searchCharacters(String query) async {
    final response =
        await http.get(Uri.parse('$baseUrl/character/?name=$query'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      return data.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search characters');
    }
  }
}
