import 'package:nasa_app/datasources/interfaces/rovers_photos_remote_datasource.dart';
import 'package:nasa_app/models/photo_model.dart';
import 'package:nasa_app/network/interfaces/api.dart';

class RoversPhotosRemoteDatasourceImpl implements RoversPhotosRemoteDatasource {
  final API api;
  final String baseUrl;

  RoversPhotosRemoteDatasourceImpl({
    required this.api,
    required this.baseUrl,
  });

  @override
  Future<List<PhotoModel>> getRoversPhotos() {}
}
