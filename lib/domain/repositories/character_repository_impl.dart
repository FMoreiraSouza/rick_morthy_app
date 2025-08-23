import 'package:rick_morthy_app/data/datasources/character_remote_datasource.dart';
import 'package:rick_morthy_app/domain/entities/character_entity.dart';
import 'package:rick_morthy_app/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CharacterEntity>> getCharacters({int page = 1}) async {
    final response = await remoteDataSource.getCharacters(page: page);
    return response.results.map((characterDto) => characterDto.toEntity()).toList();
  }

  @override
  Future<CharacterEntity> getCharacterById(int id) async {
    return await remoteDataSource.getCharacterById(id);
  }
}
