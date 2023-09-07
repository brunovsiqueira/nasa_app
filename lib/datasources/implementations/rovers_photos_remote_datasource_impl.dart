import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nasa_app/datasources/interfaces/rovers_photos_remote_datasource.dart';
import 'package:nasa_app/enums/rover_name_enum.dart';
import 'package:nasa_app/errors/exceptions/rovers_photos_exceptions.dart';
import 'package:nasa_app/models/rover_photo_item_model.dart';
import 'package:nasa_app/network/interfaces/api.dart';

class RoversPhotosRemoteDatasourceImpl implements RoversPhotosRemoteDatasource {
  final API api;
  final String baseUrl;

  RoversPhotosRemoteDatasourceImpl({
    required this.api,
    required this.baseUrl,
  });

  @override
  Future<List<RoverPhotoItemModel>> getRoversPhotos(
      RoverNameEnum roverNameEnum) async {
    final String url =
        '$baseUrl/mars-photos/api/v1/rovers/$roverNameEnum/photos';
    try {
      Response response = await api.httpGet(url: url, queryParams: {
        'sol': 1000,
        'api_key': dotenv.env['NASA_API_KEY']!,
      }); //TODO: make a paginated call and implement infinity scroll pagination
      return (response.data['photos'] as List)
          .map((e) => RoverPhotoItemModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw GetRoversPhotosException(dioException: e);
    }
  }
}
