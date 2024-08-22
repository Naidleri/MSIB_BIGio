import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterDetail extends StatelessWidget {
  final Character character;

  CharacterDetail({required this.character});

  @override
  Widget build(BuildContext context) {
    if (character == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Character Detail'),
        ),
        body: Center(
          child: Text(
            'Data karakter tidak ada',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  character.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Text(
                character.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 204, 28, 28),
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildDetailRow('Species', character.species),
            _buildDetailRow('Gender', character.gender),
            _buildDetailRow('Origin', character.originName),
            _buildDetailRow('Location', character.locationName),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(189, 0, 0, 0),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(189, 0, 0, 0),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
