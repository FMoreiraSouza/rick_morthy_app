import 'package:flutter/foundation.dart';
import 'package:rick_morthy_app/domain/model/character_model.dart';

class CharacterDetailsViewModel with ChangeNotifier {
  CharacterModel? _character;
  CharacterModel? get character => _character;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;
  bool get hasError => _error.isNotEmpty;

  void fetchArguments(Map<String, dynamic>? args) {
    _setLoading(true);

    try {
      if (args != null && args.containsKey('character')) {
        _character = args['character'] as CharacterModel;
      } else {
        _error = 'Personagem não encontrado';
      }
    } catch (e) {
      _error = 'Erro ao carregar personagem: ${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
