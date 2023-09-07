import 'package:nasa_app/models/photo_model.dart';

abstract interface class RoversPhotosRemoteDatasource {
  Future<List<PhotoModel>> getRoversPhotos();
}
