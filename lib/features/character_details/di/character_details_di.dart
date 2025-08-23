import 'package:flutter/widgets.dart';
import 'package:rick_morthy_app/core/di/dependency_manager.dart';
import 'package:rick_morthy_app/core/utils/page_dependency.dart';
import 'package:rick_morthy_app/features/character_details/presentation/viewmodel/character_details_view_model.dart';
import 'package:rick_morthy_app/features/character_details/ui/pages/character_details_page.dart';

class CharacterDetailsDI extends PageDependency {
  @override
  void init() {
    // Registra o ViewModel como singleton (assim como no exemplo)
    DependencyManager.registerSingleton<CharacterDetailsViewModel>(CharacterDetailsViewModel());
  }

  @override
  StatefulWidget getPage() {
    // Passa o ViewModel para a página, igual no exemplo
    return CharacterDetailsPage(viewModel: DependencyManager.get<CharacterDetailsViewModel>());
  }
}
