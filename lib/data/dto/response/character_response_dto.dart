import 'package:rick_morthy_app/data/dto/response/character_dto.dart';

class CharacterResponseDTO {
  final List<CharacterDTO> results;

  CharacterResponseDTO({required this.results});

  factory CharacterResponseDTO.fromJson(Map<String, dynamic> json) {
    return CharacterResponseDTO(
      results: (json['results'] as List)
          .map((character) => CharacterDTO.fromJson(character))
          .toList(),
    );
  }
}
