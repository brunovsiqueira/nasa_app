import 'package:nasa_app/models/rover_photo_item_model.dart';

abstract interface class RoversPhotosRemoteDatasource {
  Future<List<RoverPhotoItemModel>> getRoversPhotos();
}
