import 'package:get_it/get_it.dart';

class DependencyManager {
  static final GetIt _locator = GetIt.I;

  static void registerSingleton<T extends Object>(T instance) {
    if (!_locator.isRegistered<T>()) {
      _locator.registerSingleton<T>(instance);
    }
  }

  static void registerLazySingleton<T extends Object>(T Function() factory) {
    if (!_locator.isRegistered<T>()) {
      _locator.registerLazySingleton<T>(factory);
    }
  }

  static void registerFactory<T extends Object>(T Function() factory) {
    if (!_locator.isRegistered<T>()) {
      _locator.registerFactory<T>(factory);
    }
  }

  static T get<T extends Object>() => _locator.get<T>();

  static bool isRegistered<T extends Object>() => _locator.isRegistered<T>();
}
