import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';
import '../providers/favorite_provider.dart';
import '../widget/character_detail.dart';

class CharacterDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as Character;

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        actions: [
          Consumer<FavoriteProvider>(
            builder: (context, favoriteProvider, child) {
              final isFavorite =
                  favoriteProvider.favorites.any((c) => c.id == character.id);

              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () async {
                  if (isFavorite) {
                    await favoriteProvider.removeFavorite(character.id);
                  } else {
                    await favoriteProvider.addFavorite(character);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: CharacterDetail(character: character),
    );
  }
}
