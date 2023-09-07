import 'package:nasa_app/errors/failures/base_failure.dart';

class ConnectivityHasInternetAccessFailure extends BaseFailure {
  const ConnectivityHasInternetAccessFailure({
    super.message = 'No internet connection. Check your internet connection.',
    required super.exception,
    required super.stackTrace,
  });
}
