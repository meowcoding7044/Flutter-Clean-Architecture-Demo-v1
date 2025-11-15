// 1. Make properties public by removing the underscore.
class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    // 2. Ensure a clean and readable output.
    return "${prefix ?? ''}${message ?? ''}";
  }
}

class NoInternetException extends AppException {
  NoInternetException([String? message]) : super(message, "No Internet Connection");
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, ""); // Prefix can be empty for direct messages
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super(message, "Unauthorized: ");
}

class ServerException extends AppException {
  ServerException(String? message) : super(message, "Internal Server Error: ");
}
