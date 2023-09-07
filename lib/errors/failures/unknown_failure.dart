import 'package:nasa_app/errors/failures/base_failure.dart';

class UnknownFailure extends BaseFailure {
  const UnknownFailure({
    super.message = 'An unknown error has occurred. Please contact support.',
    required super.exception,
    required super.stackTrace,
  });
}
