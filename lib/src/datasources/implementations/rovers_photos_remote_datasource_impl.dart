import 'package:dio/dio.dart';
import 'package:nasa_app/src/datasources/interfaces/rovers_photos_remote_datasource.dart';
import 'package:nasa_app/src/enums/rover_name_enum.dart';
import 'package:nasa_app/src/errors/exceptions/rovers_photos_exceptions.dart';
import 'package:nasa_app/src/models/rover_photo_item_model.dart';
import 'package:nasa_app/src/network/interfaces/api.dart';

class RoversPhotosRemoteDatasourceImpl implements RoversPhotosRemoteDatasource {
  final API api;
  final String baseUrl;
  final String apiKey;

  RoversPhotosRemoteDatasourceImpl({
    required this.api,
    required this.baseUrl,
    required this.apiKey,
  });

  @override
  Future<List<RoverPhotoItemModel>> getRoversPhotos(
    RoverNameEnum roverNameEnum,
  ) async {
    final String url =
        '$baseUrl/mars-photos/api/v1/rovers/${roverNameEnum.name}/photos';
    try {
      Response response = await api.httpGet(url: url, queryParams: {
        'sol': 1000,
        'api_key': apiKey,
      }); //TODO: make a paginated call and implement infinity scroll pagination
      return (response.data['photos'] as List)
          .map((e) => RoverPhotoItemModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw GetRoversPhotosException(dioException: e);
    }
  }
}
