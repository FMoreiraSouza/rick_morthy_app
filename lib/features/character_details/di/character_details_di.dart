import 'package:flutter/widgets.dart';
import 'package:rick_morthy_app/core/utils/page_dependency.dart';
import 'package:rick_morthy_app/domain/entities/character_entity.dart';
import 'package:rick_morthy_app/features/character_details/ui/pages/character_details_page.dart';

class CharacterDetailsDI extends PageDependency {
  final dynamic arguments;

  CharacterDetailsDI({this.arguments});

  @override
  void init() {
    // Não precisa mais registrar ViewModel pois não usamos mais
  }

  @override
  StatefulWidget getPage() {
    final args = arguments as Map<String, dynamic>?;
    final character = args?['character'] as CharacterEntity?;

    // Retorna diretamente a página, assumindo que o character sempre virá
    return CharacterDetailsPage(character: character!);
  }
}
