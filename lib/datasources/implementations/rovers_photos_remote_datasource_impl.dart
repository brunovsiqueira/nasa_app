import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nasa_app/datasources/interfaces/rovers_photos_remote_datasource.dart';
import 'package:nasa_app/errors/exceptions/rovers_photos_exceptions.dart';
import 'package:nasa_app/models/rover_item_model.dart';
import 'package:nasa_app/network/interfaces/api.dart';

class RoversPhotosRemoteDatasourceImpl implements RoversPhotosRemoteDatasource {
  final API api;
  final String baseUrl;

  RoversPhotosRemoteDatasourceImpl({
    required this.api,
    required this.baseUrl,
  });

  @override
  Future<List<RoverItemModel>> getRoversPhotos() async {
    final String url = '$baseUrl/mars-photos/api/v1/rovers/curiosity/photos';
    try {
      Response response = await api.httpGet(url: url, queryParams: {
        'sol': 1000,
        'api_key': dotenv.env['NASA_API_KEY']!,
      });
      return (response.data as List)
          .map((e) => RoverItemModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw GetRoversPhotosException(dioException: e);
    }
  }
}
