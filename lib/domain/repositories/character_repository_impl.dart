import 'package:rick_morthy_app/data/datasources/character_remote_datasource.dart';
import 'package:rick_morthy_app/data/dto/request/info_request_dto.dart';
import 'package:rick_morthy_app/domain/entities/character_entity.dart';
import 'package:rick_morthy_app/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CharacterEntity>> getCharacters(InfoRequestDTO params) async {
    final response = await remoteDataSource.getCharacters(params);
    return response.results.map((characterDto) => characterDto.toEntity()).toList();
  }
}
