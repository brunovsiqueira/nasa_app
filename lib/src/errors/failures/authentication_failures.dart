import 'package:logging/logging.dart';
import 'package:nasa_app/src/errors/failures/base_failure.dart';

class FirebaseAnonymousSignInNotAllowedFailure extends BaseFailure {
  const FirebaseAnonymousSignInNotAllowedFailure({
    super.message = 'Operation not allowed. Please contact support.',
    super.level = Level.SEVERE,
    required super.exception,
    required super.stackTrace,
  });
}

class FirebaseAnonymousSignInUnknownFailure extends BaseFailure {
  const FirebaseAnonymousSignInUnknownFailure({
    super.message = 'An unknown error has occurred. Please contact support.',
    super.level = Level.SEVERE,
    required super.exception,
    required super.stackTrace,
  });
}
