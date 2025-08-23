import 'package:rick_morthy_app/data/dto/response/character_dto.dart';

class CharacterResponseDTO {
  final InfoDTO info;
  final List<CharacterDTO> results;

  CharacterResponseDTO({required this.info, required this.results});

  factory CharacterResponseDTO.fromJson(Map<String, dynamic> json) {
    return CharacterResponseDTO(
      info: InfoDTO.fromJson(json['info']),
      results: (json['results'] as List)
          .map((character) => CharacterDTO.fromJson(character))
          .toList(),
    );
  }
}

class InfoDTO {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  InfoDTO({required this.count, required this.pages, this.next, this.prev});

  factory InfoDTO.fromJson(Map<String, dynamic> json) {
    return InfoDTO(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}
