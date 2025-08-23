abstract class Failure implements Exception {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;

  static Failure fromException(dynamic exception) {
    if (exception is Failure) {
      return exception;
    }

    final errorMessage = exception.toString();

    if (errorMessage.contains('Connection') ||
        errorMessage.contains('Socket') ||
        errorMessage.contains('Network') ||
        errorMessage.contains('Timeout')) {
      return const ConnectionFailure();
    }

    if (errorMessage.contains('Server') ||
        errorMessage.contains('500') ||
        errorMessage.contains('404') ||
        errorMessage.contains('401')) {
      return ServerFailure(errorMessage);
    }

    return UnknownFailure(errorMessage);
  }
}

class ConnectionFailure extends Failure {
  const ConnectionFailure() : super('Erro de conexão');
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Erro no servidor']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Erro desconhecido']);
}
