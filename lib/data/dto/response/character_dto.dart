import 'package:rick_morthy_app/domain/entities/character_entity.dart';

class CharacterDTO {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;

  CharacterDTO({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
  });

  factory CharacterDTO.fromJson(Map<String, dynamic> json) {
    return CharacterDTO(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      image: json['image'],
    );
  }

  CharacterEntity toEntity() {
    return CharacterEntity(id: id, name: name, status: status, species: species, image: image);
  }
}
