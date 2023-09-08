import 'package:logging/logging.dart';
import 'package:nasa_app/src/errors/failures/base_failure.dart';

class ServerFailure extends BaseFailure {
  const ServerFailure({
    super.message = 'Server failure has occured.',
    super.exception,
    super.stackTrace = StackTrace.empty,
    super.level = Level.WARNING,
  });
}
