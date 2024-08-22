import 'package:flutter/material.dart';
import 'package:msibbigio/providers/favorite_provider.dart';
import 'package:msibbigio/services/favorite_services.dart';
import 'package:msibbigio/view/detail_page.dart';
import 'package:msibbigio/view/favorites_page.dart';
import 'package:msibbigio/view/homepage.dart';
import 'package:provider/provider.dart';
import 'providers/character_provider.dart';
import 'services/rick_and_morty_api.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CharacterProvider(
              apiService: RickAndMortyApi(client: http.Client())),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(favoriteService: FavoriteService()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/detail': (context) => CharacterDetailPage(),
        '/favorites': (context) => FavoritesPage(),
      },
    );
  }
}
