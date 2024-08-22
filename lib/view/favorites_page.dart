import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import 'package:msibbigio/widget/favorite_list.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<void> _fetchFavoritesFuture;

  @override
  void initState() {
    super.initState();
    _fetchFavoritesFuture = _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    await Provider.of<FavoriteProvider>(context, listen: false)
        .fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Characters'),
      ),
      body: FutureBuilder(
        future:
            _fetchFavoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (favoriteProvider.error != null) {
            return Center(child: Text('Error: ${favoriteProvider.error}'));
          } else if (favoriteProvider.favorites.isEmpty) {
            return Center(
                child: Text('Belum ada favorite karakter yang ditambahkan'));
          } else {
            return FavoriteList(
              favorites: favoriteProvider.favorites,
              onFavoriteTap: (character) {
                Navigator.pushNamed(context, '/detail', arguments: character);
              },
              onRemoveFavorite: (character) async {
                await favoriteProvider.removeFavorite(character.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          '${character.name} karakter dihapus dari favorit')),
                );
              },
            );
          }
        },
      ),
    );
  }
}
