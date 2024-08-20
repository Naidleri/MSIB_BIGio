import 'package:flutter/material.dart';
import 'package:msibbigio/widget/character_detail.dart';

class CharacterDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('character fav'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () async {},
          ),
        ],
      ),
      body: CharacterDetail(),
    );
  }
}
