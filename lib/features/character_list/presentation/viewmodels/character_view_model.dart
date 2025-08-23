import 'package:flutter/foundation.dart';
import 'package:rick_morthy_app/core/constants/core_app.dart';
import 'package:rick_morthy_app/core/constants/screen_states.dart';
import 'package:rick_morthy_app/core/network/failure.dart';
import 'package:rick_morthy_app/data/dto/request/info_request_dto.dart';
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
  bool get hasMore => _hasMore;

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
      final params = InfoRequestDTO(page: _currentPage, size: CoreApp.pageSize);

      final newCharacters = await repository.getCharacters(params);

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
      // Convertendo a exception para Failure
      final failure = _convertExceptionToFailure(e);
      _checkErrorState(failure);
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

  // Método para tratar erros específicos
  void _checkErrorState(Failure failure) {
    _error = failure.message;

    switch (failure.runtimeType) {
      case const (ConnectionFailure):
        _updateState(ScreenStates.noConnection);
        break;
      default:
        _updateState(ScreenStates.errorState);
    }
  }

  // Método auxiliar para converter exceptions em Failures
  Failure _convertExceptionToFailure(dynamic exception) {
    if (exception is Failure) {
      return exception;
    }

    final errorMessage = exception.toString();

    // Você pode adicionar mais verificações específicas aqui
    if (errorMessage.contains('Connection') ||
        errorMessage.contains('Socket') ||
        errorMessage.contains('Network')) {
      return const ConnectionFailure();
    }

    if (errorMessage.contains('Server') ||
        errorMessage.contains('500') ||
        errorMessage.contains('404')) {
      return ServerFailure(errorMessage);
    }

    return UnknownFailure(errorMessage);
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
