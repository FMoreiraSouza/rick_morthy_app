import 'package:rick_morthy_app/data/dto/request/info_request_dto.dart';
import 'package:rick_morthy_app/domain/model/character_model.dart';

abstract class CharacterRepository {
  Future<List<CharacterModel>> getCharacters(InfoRequestDTO params);
}
