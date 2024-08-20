import 'package:flutter/material.dart';

class CharacterDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String name = 'Character 1';
    final String species = 'Species 1';
    final String gender = 'Gender 1';
    final String origin = 'Origin 1';
    final String location = 'Location 1';
    final String imageUrl = 'https://via.placeholder.com/150';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            SizedBox(height: 16),
            Text('Name: $name', style: TextStyle(fontSize: 18)),
            Text('Species: $species', style: TextStyle(fontSize: 18)),
            Text('Gender: $gender', style: TextStyle(fontSize: 18)),
            Text('Origin: $origin', style: TextStyle(fontSize: 18)),
            Text('Location: $location', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
