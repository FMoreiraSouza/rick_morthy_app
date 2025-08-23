// features/character_details/presentation/pages/character_details_di.dart
import 'package:flutter/material.dart';
import 'package:rick_morthy_app/core/di/dependency_manager.dart';
import 'package:rick_morthy_app/core/utils/page_dependency.dart';
import 'package:rick_morthy_app/domain/repositories/character_repository.dart';
import 'package:rick_morthy_app/features/character_details/presentation/viewmodels/character_details_view_model.dart';
import 'package:rick_morthy_app/features/character_details/ui/pages/character_details_page.dart';

class CharacterDetailsDI implements PageDependency {
  final dynamic arguments;

  CharacterDetailsDI({this.arguments});

  @override
  void init() {
    // ViewModel - Factory para criar nova instância a cada uso
    DependencyManager.registerFactory<CharacterDetailsViewModel>(
      () => CharacterDetailsViewModel(DependencyManager.get<CharacterRepository>()),
    );
  }

  @override
  StatefulWidget getPage() {
    final args = arguments as Map<String, dynamic>?;
    final characterId = args?['characterId'] as int? ?? 0;

    return CharacterDetailsPage(characterId: characterId);
  }
}
