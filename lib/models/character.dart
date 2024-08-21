class Character {
  final int id;
  final String name;
  final String species;
  final String gender;
  final String originName;
  final String locationName;
  final String imageUrl;

  Character({
    required this.id,
    required this.name,
    required this.species,
    required this.gender,
    required this.originName,
    required this.locationName,
    required this.imageUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      gender: json['gender'],
      originName: json['origin']['name'] ?? 'Unknown',
      locationName: json['location']['name'] ?? 'Unknown',
      imageUrl: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'gender': gender,
      'origin': {
        'name': originName,
      },
      'location': {
        'name': locationName,
      },
      'image': imageUrl,
    };
  }
}
