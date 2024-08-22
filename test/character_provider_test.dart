import 'package:flutter_test/flutter_test.dart';
import 'package:msibbigio/models/character.dart';
import 'package:msibbigio/providers/character_provider.dart';
import 'package:msibbigio/services/rick_and_morty_api.dart';

import 'mock_rickandmorty_api.dart';

class MockRickAndMortyApi extends RickAndMortyApi {
  MockRickAndMortyApi() : super(client: MockClient());

  List<Character> mockCharacters = [];

  @override
  Future<List<Character>> fetchCharacters({int page = 1}) async {
    return mockCharacters;
  }
}

void main() {
  group('CharacterProvider', () {
    late CharacterProvider provider;
    late MockRickAndMortyApi mockApiService;

    setUp(() {
      mockApiService = MockRickAndMortyApi();
      provider = CharacterProvider(apiService: mockApiService);
    });

    test('fetchCharacters memperbarui daftar karakter dan status loading',
        () async {
      final mockCharacters = [
        Character(
          id: 1,
          name: 'Rick Sanchez',
          species: 'Human',
          gender: 'Male',
          originName: 'Earth (C-137)',
          locationName: 'Earth (Replacement Dimension)',
          imageUrl: 'https://rickandmortyapi.com/api/character/avatar/581.jpeg',
        ),
      ];

      mockApiService.mockCharacters = mockCharacters;

      final fetchFuture = provider.fetchCharacters();

      expect(provider.isLoading, true);
      await fetchFuture;
      expect(provider.isLoading, false);

      expect(provider.characters, mockCharacters);
      expect(provider.hasMore, true);
    });

    test('fetchCharacters menangani error dengan benar', () async {
      mockApiService.mockCharacters = [];

      final fetchFuture = provider.fetchCharacters();

      expect(provider.isLoading, true);
      await fetchFuture;
      expect(provider.isLoading, false);

      expect(provider.characters, []);
    });
  });
}
