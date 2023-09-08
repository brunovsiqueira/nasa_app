import 'package:logging/logging.dart';
import 'package:nasa_app/src/errors/failures/server_failure.dart';

class GetRoversPhotosFailure extends ServerFailure {
  const GetRoversPhotosFailure({
    super.message = 'Error getting rovers photos. Try again later.',
    required super.exception,
    super.level = Level.SEVERE,
    super.stackTrace,
  });
}
