import 'package:dartz/dartz.dart';
import 'package:nasa_app/src/enums/rover_name_enum.dart';
import 'package:nasa_app/src/errors/failures/base_failure.dart';
import 'package:nasa_app/src/models/rover_photo_item_model.dart';

abstract interface class RoversPhotosService {
  Future<Either<BaseFailure, List<RoverPhotoItemModel>>> getRoversPhotos(
    RoverNameEnum roverNameEnum,
  );
}
