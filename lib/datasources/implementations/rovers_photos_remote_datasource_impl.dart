import 'package:dio/dio.dart';
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
  Future<List<PhotoModel>> getRoversPhotos() async {
    final String url = '$baseUrl/mars-photos/api/v1/rovers/curiosity/photos';
    try {
      Response response = await api.httpGet(url: url, queryParams: {
        'sol': 1000,
        'api_key':
            'pAr57XMlhMYotz6Xs1H73qarbSWru8C1jP1kNEBh', //FIXME: but it on .env
      });
      return (response.data as List)
          .map((e) => PhotoModel.fromJson(e))
          .toList();
    } on DioException catch (e, stackTrace) {
      throw GetRoversPhotosException(dioException: e, stackTrace: stackTrace);
    } catch (e, stackTrace) {
      throw UnmappedException(exception: e, stackTrace: stackTrace);
    }
  }
}
