import 'package:nasa_app/errors/failures/base_failure.dart';

class GetRoversPhotosFailure extends BaseFailure {
  const GetRoversPhotosFailure({
    super.message = 'Error getting rovers photos. Try again later.',
    required super.exception,
    required super.stackTrace,
  });
}
