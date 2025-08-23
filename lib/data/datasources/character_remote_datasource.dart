import 'package:rick_morthy_app/data/dto/response/character_response_dto.dart';
import 'package:rick_morthy_app/domain/entities/character_entity.dart';

abstract class CharacterRemoteDataSource {
  Future<CharacterResponseDTO> getCharacters({int page = 1});
  Future<CharacterEntity> getCharacterById(int id);
}
