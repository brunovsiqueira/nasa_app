import 'package:dartz/dartz.dart';
import 'package:nasa_app/errors/failures/base_failure.dart';
import 'package:nasa_app/models/rover_photo_item_model.dart';

abstract interface class RoversPhotosService {
  Future<Either<BaseFailure, List<RoverPhotoItemModel>>> getRoversPhotos();
}
