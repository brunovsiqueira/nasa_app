import 'package:nasa_app/errors/failures/base_failure.dart';

class FirebaseAnonymousSignInNotAllowedFailure extends BaseFailure {
  FirebaseAnonymousSignInNotAllowedFailure({
    super.message = 'Operation not allowed. Please contact support.',
    required super.exception,
    required super.stackTrace,
  });
}

class FirebaseAnonymousSignInUnknownFailure extends BaseFailure {
  FirebaseAnonymousSignInUnknownFailure({
    super.message = 'An unknown error has occurred. Please contact support.',
    required super.exception,
    required super.stackTrace,
  });
}