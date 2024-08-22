import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:msibbigio/services/rick_and_morty_api.dart';
import 'package:msibbigio/models/character.dart';

class MockClient extends Mock implements http.Client {}

class MockRickAndMortyApi extends RickAndMortyApi {
  MockRickAndMortyApi() : super(client: MockClient());

  List<Character> mockCharacters = [];

  @override
  Future<List<Character>> fetchCharacters({int page = 1}) async {
    return mockCharacters;
  }
}
