import 'package:rick_morthy_app/domain/entities/character_entity.dart';

class CharacterDTO {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String url;
  final DateTime created;
  final CharacterLocationDTO origin;
  final CharacterLocationDTO location;

  CharacterDTO({
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

  factory CharacterDTO.fromJson(Map<String, dynamic> json) {
    return CharacterDTO(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      url: json['url'],
      created: DateTime.parse(json['created']),
      origin: CharacterLocationDTO.fromJson(json['origin']),
      location: CharacterLocationDTO.fromJson(json['location']),
    );
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      image: image,
      url: url,
      created: created,
      origin: CharacterLocation(name: origin.name, url: origin.url),
      location: CharacterLocation(name: location.name, url: location.url),
    );
  }
}

class CharacterLocationDTO {
  final String name;
  final String url;

  CharacterLocationDTO({required this.name, required this.url});

  factory CharacterLocationDTO.fromJson(Map<String, dynamic> json) {
    return CharacterLocationDTO(name: json['name'], url: json['url']);
  }
}
