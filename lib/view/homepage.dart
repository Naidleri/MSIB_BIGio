import 'package:flutter/material.dart';
import 'package:msibbigio/view/search_page.dart';
import 'package:msibbigio/widget/character_list.dart';
import 'package:provider/provider.dart';
import '../providers/character_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CharacterProvider>(context, listen: false).fetchCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty Characters'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CharacterSearchDelegate(characterProvider),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: Consumer<CharacterProvider>(
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
      ),
    );
  }
}
