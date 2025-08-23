import 'package:flutter/widgets.dart';
import 'package:rick_morthy_app/core/di/dependency_manager.dart';
import 'package:rick_morthy_app/core/di/dio_di_manager.dart';
import 'package:rick_morthy_app/core/utils/page_dependency.dart';
import 'package:rick_morthy_app/data/datasources/character_remote_datasource.dart';
import 'package:rick_morthy_app/data/datasources/character_remote_datasource_impl.dart';
import 'package:rick_morthy_app/domain/repositories/character_repository.dart';
import 'package:rick_morthy_app/domain/repositories/character_repository_impl.dart';
import 'package:rick_morthy_app/features/character_list/presentation/viewmodels/character_view_model.dart';
import 'package:rick_morthy_app/features/character_list/ui/pages/character_list_page.dart';

class CharacterListDI extends PageDependency {
  @override
  void init() {
    // DataSource
    DependencyManager.registerSingleton<CharacterRemoteDataSource>(
      CharacterRemoteDataSourceImpl(DioDIManager.getDio()),
    );

    // Repository
    DependencyManager.registerSingleton<CharacterRepository>(
      CharacterRepositoryImpl(DependencyManager.get<CharacterRemoteDataSource>()),
    );

    var characterRepository = DependencyManager.get<CharacterRepository>();

    // ViewModel
    DependencyManager.registerSingleton<CharacterViewModel>(
      CharacterViewModel(characterRepository),
    );
  }

  @override
  StatefulWidget getPage() {
    return CharacterListPage(viewModel: DependencyManager.get<CharacterViewModel>());
  }
}
