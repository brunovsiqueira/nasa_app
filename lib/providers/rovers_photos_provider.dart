import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_app/datasources/implementations/rovers_photos_remote_datasource_impl.dart';
import 'package:nasa_app/models/rover_item_model.dart';
import 'package:nasa_app/providers/api_provider.dart';
import 'package:nasa_app/providers/logger_service_provider.dart';
import 'package:nasa_app/services/implementations/rovers_photos_service_impl.dart';
import 'package:nasa_app/services/interfaces/rovers_photos_service.dart';

final roversPhotoServiceProvider = Provider<RoversPhotosService>((ref) {
  return RoversPhotosServiceImpl(
    loggerService: ref.read(loggerServiceProvider),
    roversPhotosRemoteDatasource: RoversPhotosRemoteDatasourceImpl(
        api: ref.read(apiProvider), baseUrl: dotenv.env['NASA_URL']!),
  );
});

final roversPhotosProvider =
    FutureProvider.autoDispose<List<RoverItemModel>>((ref) async {
  var result = await ref.read(roversPhotoServiceProvider).getRoversPhotos();
  result.fold((failure) {
    throw failure;
  }, (photoList) {
    return photoList;
  });
  return [];
});
