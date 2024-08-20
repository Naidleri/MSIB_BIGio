import 'package:flutter/material.dart';
import 'package:msibbigio/widget/character_detail.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';

class CharacterDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as Character;

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () async {},
          ),
        ],
      ),
      body: CharacterDetail(character: character),
    );
  }
}
