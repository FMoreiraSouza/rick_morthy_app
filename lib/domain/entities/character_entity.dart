// domain/entities/character_entity.dart
class CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String url;
  final DateTime created;
  final CharacterLocation origin;
  final CharacterLocation location;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.url,
    required this.created,
    required this.origin,
    required this.location,
  });

  factory CharacterEntity.fromJson(Map<String, dynamic> json) {
    return CharacterEntity(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      url: json['url'],
      created: DateTime.parse(json['created']),
      origin: CharacterLocation.fromJson(json['origin']),
      location: CharacterLocation.fromJson(json['location']),
    );
  }
}

class CharacterLocation {
  final String name;
  final String url;

  CharacterLocation({required this.name, required this.url});

  factory CharacterLocation.fromJson(Map<String, dynamic> json) {
    return CharacterLocation(name: json['name'], url: json['url']);
  }
}
