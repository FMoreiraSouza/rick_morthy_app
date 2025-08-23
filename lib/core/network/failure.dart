abstract class Failure implements Exception {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
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
