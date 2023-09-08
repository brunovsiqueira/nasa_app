import 'package:nasa_app/src/enums/rover_name_enum.dart';
import 'package:nasa_app/src/models/rover_photo_item_model.dart';

abstract interface class RoversPhotosRemoteDatasource {
  Future<List<RoverPhotoItemModel>> getRoversPhotos(
    RoverNameEnum roverNameEnum,
  );
}
