import 'package:rick_morthy_app/data/dto/request/info_request_dto.dart';
import 'package:rick_morthy_app/data/dto/response/character_response_dto.dart';

abstract class CharacterRemoteDataSource {
  Future<CharacterResponseDTO> getCharacters(InfoRequestDTO params);
}
