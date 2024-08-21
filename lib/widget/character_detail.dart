import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterDetail extends StatelessWidget {
  final Character character;

  CharacterDetail({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(character.imageUrl),
            SizedBox(height: 16),
            Text('Name: ${character.name}', style: TextStyle(fontSize: 18)),
            Text('Species: ${character.species}', style: TextStyle(fontSize: 18)),
            Text('Gender: ${character.gender}', style: TextStyle(fontSize: 18)),
            Text('Origin: ${character.originName}', style: TextStyle(fontSize: 18)),
            Text('Location: ${character.locationName}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
