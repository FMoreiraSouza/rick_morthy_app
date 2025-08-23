import 'package:flutter/material.dart';
import 'package:rick_morthy_app/app_routes.dart';
import 'package:rick_morthy_app/features/character_details/di/character_details_di.dart';
import 'package:rick_morthy_app/features/character_list/di/character_list_di.dart';

class AppRouteManager {
  static final AppRouteManager _instance = AppRouteManager._internal();

  factory AppRouteManager() => _instance;

  static AppRouteManager get instance => _instance;

  AppRouteManager._internal();

  Map<String, WidgetBuilder> getPages() {
    return {
      AppRoutes.characterList: (context) {
        final di = CharacterListDI();
        di.init();
        return di.getPage();
      },
      AppRoutes.characterDetails: (context) {
        final di = CharacterDetailsDI();
        di.init();
        return di.getPage();
      },
    };
  }
}
