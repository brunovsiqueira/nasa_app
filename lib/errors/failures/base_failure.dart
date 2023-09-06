import 'package:logging/logging.dart';

class BaseFailure {
  final String message;
  Level? level;
  final dynamic exception;
  final StackTrace stackTrace;

  BaseFailure({
    required this.message,
    required this.exception,
    required this.stackTrace,
  });
}
