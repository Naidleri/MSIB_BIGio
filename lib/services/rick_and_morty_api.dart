import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/character.dart';

class RickAndMortyApi {
  final http.Client client;
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  RickAndMortyApi({required this.client});

  Future<List<Character>> fetchCharacters({int page = 1}) async {
    final response = await client.get(Uri.parse('$baseUrl/character?page=$page'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['results'] != null && data['results'] is List) {
        final List<dynamic> results = data['results'];
        return results.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception('Failed to parse characters');
      }
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<Character> fetchCharacterById(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/character/$id'));
    if (response.statusCode == 200) {
      return Character.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load character details');
    }
  }

  Future<List<Character>> searchCharacters(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/character/?name=$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['results'] != null && data['results'] is List) {
        final List<dynamic> results = data['results'];
        return results.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception('Failed to parse characters');
      }
    } else {
      throw Exception('Failed to search characters');
    }
  }
}
