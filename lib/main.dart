import 'package:flutter/material.dart';
import 'package:msibbigio/view/detail_page.dart';
import 'package:msibbigio/view/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (context) => Homepage(),
        '/detail': (context) => CharacterDetailPage(),
      },
    );
  }
}
