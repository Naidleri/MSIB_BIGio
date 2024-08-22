import 'package:flutter_test/flutter_test.dart';
import 'package:msibbigio/models/character.dart';

void main() {
  group('Character', () {
    test('fromJson harus membuat objek Character yang benar', () {
      final json = {
        'id': 1,
        'name': 'Rick Sanchez',
        'species': 'Human',
        'gender': 'Male',
        'origin': {'name': 'Earth (C-137)'},
        'location': {'name': 'Citadel of Ricks'},
        'image': 'https://rickandmortyapi.com/api/character/avatar/581.jpeg',
      };

      final character = Character.fromJson(json);

      expect(character.id, 1);
      expect(character.name, 'Rick Sanchez');
      expect(character.species, 'Human');
      expect(character.gender, 'Male');
      expect(character.originName, 'Earth (C-137)');
      expect(character.locationName, 'Citadel of Ricks');
      expect(character.imageUrl,
          'https://rickandmortyapi.com/api/character/avatar/581.jpeg');
    });

    test('fromJson harus menangani nilai null dengan benar', () {
      final json = {
        'id': 1,
        'name': 'Morty Smith',
        'species': 'Human',
        'gender': 'Male',
        'origin': {},
        'location': {},
        'image': 'https://rickandmortyapi.com/api/character/avatar/581.jpeg',
      };

      final character = Character.fromJson(json);

      expect(character.id, 1);
      expect(character.name, 'Morty Smith');
      expect(character.species, 'Human');
      expect(character.gender, 'Male');
      expect(character.originName, 'Unknown');
      expect(character.locationName, 'Unknown');
      expect(character.imageUrl,
          'https://rickandmortyapi.com/api/character/avatar/581.jpeg');
    });

    test('toJson harus menghasilkan map JSON yang benar', () {
      final character = Character(
        id: 1,
        name: 'Rick Sanchez',
        species: 'Human',
        gender: 'Male',
        originName: 'Earth (C-137)',
        locationName: 'Citadel of Ricks',
        imageUrl: 'https://rickandmortyapi.com/api/character/avatar/581.jpeg',
      );

      final json = character.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Rick Sanchez');
      expect(json['species'], 'Human');
      expect(json['gender'], 'Male');
      expect(json['origin']['name'], 'Earth (C-137)');
      expect(json['location']['name'], 'Citadel of Ricks');
      expect(json['image'],
          'https://rickandmortyapi.com/api/character/avatar/581.jpeg');
    });
  });
}
