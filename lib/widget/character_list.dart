import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterList extends StatelessWidget {
  final List<Character> characters;
  final Function(Character) onCharacterTap;

  CharacterList({required this.characters, required this.onCharacterTap});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final character = characters[index];
                return GestureDetector(
                  onTap: () => onCharacterTap(character),
                  child: GridTile(
                    child: Image.network(character.imageUrl, fit: BoxFit.cover),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(character.name),
                      subtitle: Text(character.species),
                    ),
                  ),
                );
              },
              childCount: characters.length,
            ),
          ),
        ),
      ],
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 6;
    if (width > 800) return 4;
    if (width > 600) return 3;
    return 2;
  }
}
