import 'package:rick_morthy_app/data/dto/response/character_response_dto.dart';

abstract class CharacterRemoteDataSource {
  Future<CharacterResponseDTO> getCharacters({int page = 1});
}
