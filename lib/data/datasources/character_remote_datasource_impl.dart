import 'package:dio/dio.dart';
import 'package:rick_morthy_app/data/datasources/character_remote_datasource.dart';
import 'package:rick_morthy_app/data/dto/request/info_request_dto.dart';
import 'package:rick_morthy_app/data/dto/response/character_response_dto.dart';

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSourceImpl(this.dio);

  @override
  Future<CharacterResponseDTO> getCharacters(InfoRequestDTO params) async {
    try {
      final response = await dio.get('character', queryParameters: params.toMap());
      return CharacterResponseDTO.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load characters: ${e.message}');
    }
  }
}
