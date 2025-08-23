import 'package:dio/dio.dart';
import 'package:rick_morthy_app/core/di/dependency_manager.dart';

class DioDIManager {
  static void registerDio() {
    DependencyManager.registerSingleton<Dio>(
      Dio(
        BaseOptions(
          baseUrl: 'https://rickandmortyapi.com/api/',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      ),
    );
  }

  static Dio getDio() => DependencyManager.get<Dio>();
}
