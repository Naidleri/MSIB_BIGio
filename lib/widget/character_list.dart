import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterList extends StatelessWidget {
  final List<Character> characters;
  final Function(Character) onCharacterTap;

  CharacterList({required this.characters, required this.onCharacterTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return ListTile(
          leading: Image.network(character.imageUrl),
          title: Text(character.name),
          subtitle: Text(character.species),
          onTap: () => onCharacterTap(character),
        );
      },
    );
  }
}
