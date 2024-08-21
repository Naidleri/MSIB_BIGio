import 'package:flutter/material.dart';
import 'package:msibbigio/providers/character_provider.dart';
import 'package:msibbigio/widget/character_list.dart';
import 'package:provider/provider.dart';

class CharacterSearchDelegate extends SearchDelegate {
  final CharacterProvider characterProvider;

  CharacterSearchDelegate(this.characterProvider);

  @override
  String get searchFieldLabel => 'Mencari karakter...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          characterProvider.clearSearch();
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      characterProvider.searchCharacters(query);
    });

    return Consumer<CharacterProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}'));
        } else if (provider.characters.isEmpty) {
          return Center(child: Text('Karakter tidak ditemukan'));
        } else {
          return CharacterList(
            characters: provider.characters,
            onCharacterTap: (character) {
              Navigator.pushNamed(context, '/detail', arguments: character);
            },
            onLoadMore: () => provider.fetchCharacters(loadMore: true),
            hasMore: provider.hasMore,
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
