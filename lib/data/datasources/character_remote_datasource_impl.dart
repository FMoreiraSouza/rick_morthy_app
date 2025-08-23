// data/datasources/character_remote_datasource_impl.dart
import 'package:dio/dio.dart';
import 'package:rick_morthy_app/data/datasources/character_remote_datasource.dart';
import 'package:rick_morthy_app/data/dto/response/character_response_dto.dart';
import 'package:rick_morthy_app/domain/entities/character_entity.dart';

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSourceImpl(this.dio);

  @override
  Future<CharacterResponseDTO> getCharacters({int page = 1}) async {
    try {
      final response = await dio.get('character?page=$page');
      return CharacterResponseDTO.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load characters: ${e.message}');
    }
  }

  @override
  Future<CharacterEntity> getCharacterById(int id) async {
    try {
      final response = await dio.get('character/$id');
      return CharacterEntity.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load character: ${e.message}');
    }
  }
}
