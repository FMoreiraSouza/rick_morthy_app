import 'package:dio/dio.dart';
import 'package:rick_morthy_app/data/datasources/character_remote_datasource.dart';
import 'package:rick_morthy_app/data/dto/response/character_response_dto.dart';

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSourceImpl(this.dio);

  @override
  Future<CharacterResponseDTO> getCharacters({int page = 1}) async {
    try {
      final response = await dio.get('character', queryParameters: {'page': page});
      return CharacterResponseDTO.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load characters: ${e.message}');
    }
  }
}
