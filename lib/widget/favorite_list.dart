import 'package:flutter/material.dart';
import '../models/character.dart';

class FavoriteList extends StatelessWidget {
  final List<Character> favorites;
  final Function(Character) onFavoriteTap;
  final Function(Character) onRemoveFavorite;

  FavoriteList({
    required this.favorites,
    required this.onFavoriteTap,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final character = favorites[index];
        return ListTile(
          leading: Image.network(character.imageUrl),
          title: Text(character.name),
          subtitle: Text(character.species),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => onRemoveFavorite(character),
          ),
          onTap: () => onFavoriteTap(character),
        );
      },
    );
  }
}
