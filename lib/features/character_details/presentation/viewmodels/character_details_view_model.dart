import 'package:flutter/foundation.dart';
import 'package:rick_morthy_app/domain/entities/character_entity.dart';
import 'package:rick_morthy_app/domain/repositories/character_repository.dart';

class CharacterDetailsViewModel with ChangeNotifier {
  final CharacterRepository repository;

  CharacterDetailsViewModel(this.repository);

  CharacterEntity? _character;
  CharacterEntity? get character => _character;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;
  bool get hasError => _error.isNotEmpty;

  Future<void> loadCharacter(int id) async {
    _setLoading(true);
    _error = '';

    try {
      _character = await repository.getCharacterById(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
