import 'package:movies_app/core/network/error_message_model.dart';

class ServerExceptions implements Exception {
  const ServerExceptions({required this.errorMessageModel});

  final ErrorMessageModel errorMessageModel;
}

class LocalDataBaseExceptions implements Exception {
  const LocalDataBaseExceptions({required this.message});
  final String message;
}
