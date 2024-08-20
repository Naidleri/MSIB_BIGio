import 'package:flutter/material.dart';

class CharacterList extends StatelessWidget {
  final Function(Map<String, String>)? onCharacterTap;

  CharacterList({this.onCharacterTap});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> characters = [
      {
        'name': 'Character 1',
        'species': 'Species 1',
        'image': 'https://via.placeholder.com/150'
      },
      {
        'name': 'Character 2',
        'species': 'Species 2',
        'image': 'https://via.placeholder.com/150'
      },
      {
        'name': 'Character 3',
        'species': 'Species 3',
        'image': 'https://via.placeholder.com/150'
      },
    ];

    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return ListTile(
          leading: Image.network(character['image']!),
          title: Text(character['name']!),
          subtitle: Text(character['species']!),
          onTap: () {
            if (onCharacterTap != null) {
              onCharacterTap!(character);
            }
          },
        );
      },
    );
  }
}
