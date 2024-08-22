import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:msibbigio/models/character.dart';
import 'dart:convert';

import 'package:msibbigio/services/rick_and_morty_api.dart';


class MockHttpClient extends http.BaseClient {
  final http.Client _inner;

  MockHttpClient(this._inner);

  final Map<Uri, http.Response> _responses = {};

  void whenGet(Uri uri, http.Response response) {
    _responses[uri] = response;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (_responses.containsKey(request.url)) {
      return http.StreamedResponse(
          Stream.fromIterable([_responses[request.url]!.bodyBytes]),
          _responses[request.url]!.statusCode,
          request: request);
    }
    return _inner.send(request);
  }
}

void main() {
  group('RickAndMortyApi', () {
    late RickAndMortyApi apiService;
    late MockHttpClient mockClient;

    setUp(() {
      mockClient = MockHttpClient(http.Client());
      apiService = RickAndMortyApi(client: mockClient);
    });

    test('fetchCharacters mengembalikan daftar karakter jika request berhasil', () async {
      final mockResponse = {
        'results': [
          {
            'id': 1,
            'name': 'Rick Sanchez',
            'species': 'Human',
            'gender': 'Male',
            'origin': {'name': 'Earth (C-137)'},
            'location': {'name': 'Earth (Replacement Dimension)'},
            'image': 'https://rickandmortyapi.com/api/character/avatar/581.jpeg',
          }
        ]
      };

      mockClient.whenGet(
          Uri.parse('https://rickandmortyapi.com/api/character?page=1'),
          http.Response(jsonEncode(mockResponse), 200));

      final characters = await apiService.fetchCharacters(page: 1);

      expect(characters, isA<List<Character>>());
      expect(characters.length, 1);
      expect(characters[0].name, 'Rick Sanchez');
    });

    test('fetchCharacters melempar exception jika request gagal', () async {
      mockClient.whenGet(
          Uri.parse('https://rickandmortyapi.com/api/character?page=1'),
          http.Response('Not Found', 404));

      expect(apiService.fetchCharacters(page: 1), throwsException);
    });
  });
}
