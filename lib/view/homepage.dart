import 'package:flutter/material.dart';
import 'package:msibbigio/view/detail_page.dart';
import 'package:msibbigio/widget/character_list.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty Characters'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CharacterList(
          onCharacterTap: (character) {
            print('Tapped on ${character['name']}');
            Navigator.pushNamed(context, '/detail');
          },
        ),
      ),
    );
  }
}
