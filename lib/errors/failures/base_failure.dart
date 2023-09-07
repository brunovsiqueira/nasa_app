import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

class BaseFailure extends Equatable {
  final String message;
  final Level level;
  final dynamic exception;
  final StackTrace stackTrace;

  const BaseFailure({
    required this.message,
    required this.exception,
    required this.stackTrace,
    this.level = Level.FINE,
  });

  @override
  List<Object?> get props => [
        message,
        exception,
        stackTrace,
        level,
      ];
}
