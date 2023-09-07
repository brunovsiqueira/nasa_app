import 'package:nasa_app/models/rover_item_model.dart';

abstract interface class RoversPhotosRemoteDatasource {
  Future<List<RoverItemModel>> getRoversPhotos();
}
