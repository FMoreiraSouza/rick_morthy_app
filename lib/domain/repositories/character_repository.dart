import 'package:rick_morthy_app/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<List<CharacterEntity>> getCharacters({int page = 1});
  Future<CharacterEntity> getCharacterById(int id);
}
