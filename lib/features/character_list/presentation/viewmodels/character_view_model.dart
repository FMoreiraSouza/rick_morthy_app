import 'package:flutter/foundation.dart';
import 'package:rick_morthy_app/core/constants/screen_states.dart';
import 'package:rick_morthy_app/domain/entities/character_entity.dart';
import 'package:rick_morthy_app/domain/repositories/character_repository.dart';

class CharacterViewModel with ChangeNotifier {
  final CharacterRepository repository;

  CharacterViewModel(this.repository);

  final List<CharacterEntity> _characters = [];
  List<CharacterEntity> get characters => _characters;

  String _error = '';
  String get error => _error;
  bool get hasError => _error.isNotEmpty;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _currentPage = 1;
  bool _hasMore = true;
  bool get hasMore => _hasMore; // ADICIONE ESTA LINHA

  final ScreenStates _state = ScreenStates(currentState: ScreenStates.loadingState);
  int get state => _state.currentState;

  Future<void> loadCharacters() async {
    if (_isLoading || !_hasMore) return;

    if (_currentPage == 1) {
      _updateState(ScreenStates.loadingState);
    }

    _setLoading(true);
    _error = '';

    try {
      final newCharacters = await repository.getCharacters(page: _currentPage);

      if (newCharacters.isEmpty && _characters.isEmpty) {
        _updateState(ScreenStates.emptyState);
      } else {
        if (newCharacters.isEmpty) {
          _hasMore = false;
        } else {
          _characters.addAll(newCharacters);
          _currentPage++;
        }
        _updateState(ScreenStates.successState);
      }
    } catch (e) {
      _error = e.toString();
      _updateState(ScreenStates.errorState);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshCharacters() async {
    _characters.clear();
    _currentPage = 1;
    _hasMore = true;
    _error = '';
    await loadCharacters();
  }

  Future<void> loadNextPage() async {
    if (!_isLoading && _hasMore) {
      await loadCharacters();
    }
  }

  // Métodos privados para gerenciar estado
  void _updateState(int newState) {
    _state.currentState = newState;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
