import 'package:flutter/widgets.dart';
import 'package:rick_morthy_app/core/di/dependency_manager.dart';
import 'package:rick_morthy_app/core/di/dio_di_manager.dart';
import 'package:rick_morthy_app/core/network/drivers/connectivity_driver.dart';
import 'package:rick_morthy_app/core/network/drivers/connectivity_driver_impl.dart';
import 'package:rick_morthy_app/core/utils/page_dependency.dart';
import 'package:rick_morthy_app/data/datasources/character_remote_datasource.dart';
import 'package:rick_morthy_app/data/datasources/character_remote_datasource_impl.dart';
import 'package:rick_morthy_app/domain/repositories/character_repository.dart';
import 'package:rick_morthy_app/domain/repositories/character_repository_impl.dart';
import 'package:rick_morthy_app/features/character_list/presentation/viewmodels/character_list_view_model.dart';
import 'package:rick_morthy_app/features/character_list/view/character_list_view.dart';

class CharacterListDI extends PageDependency {
  @override
  void init() {
    DependencyManager.registerSingleton<ConnectivityDriver>(ConnectivityDriverImpl());

    DependencyManager.registerSingleton<CharacterRemoteDataSource>(
      CharacterRemoteDataSourceImpl(
        dio: DioDIManager.getDio(),
        connectivityDriver: DependencyManager.get<ConnectivityDriver>(),
      ),
    );

    DependencyManager.registerSingleton<CharacterRepository>(
      CharacterRepositoryImpl(DependencyManager.get<CharacterRemoteDataSource>()),
    );

    var characterRepository = DependencyManager.get<CharacterRepository>();

    DependencyManager.registerSingleton<CharacterListViewModel>(
      CharacterListViewModel(characterRepository),
    );
  }

  @override
  StatefulWidget getPage() {
    return CharacterListView(viewModel: DependencyManager.get<CharacterListViewModel>());
  }
}
