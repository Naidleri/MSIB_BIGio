import 'package:flutter/material.dart';
import 'package:msibbigio/view/detail_page.dart';
import 'package:msibbigio/view/homepage.dart';
import 'package:provider/provider.dart';
import 'models/character.dart';
import 'providers/character_provider.dart';
import 'services/rick_and_morty_api.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CharacterProvider(apiService: RickAndMortyApi()),
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
      title: 'Rick and Morty App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/detail': (context) => CharacterDetailPage(),
      },
    );
  }
}
