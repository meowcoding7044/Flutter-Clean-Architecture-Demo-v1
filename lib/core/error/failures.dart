import 'package:equatable/equatable.dart';

// A generic Failure class that all other specific failures will extend.
// Using Equatable to allow for value comparison.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// Represents a failure that occurs when there is a server-side error (e.g., 500 status code).
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// Represents a failure due to network issues (e.g., no internet connection).
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

// Can be used for other, more generic failures.
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
