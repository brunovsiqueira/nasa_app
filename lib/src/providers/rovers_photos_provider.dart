import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_app/src/datasources/implementations/rovers_photos_remote_datasource_impl.dart';
import 'package:nasa_app/src/enums/rover_name_enum.dart';
import 'package:nasa_app/src/models/rover_photo_item_model.dart';
import 'package:nasa_app/src/providers/api_provider.dart';
import 'package:nasa_app/src/providers/logger_service_provider.dart';
import 'package:nasa_app/src/services/implementations/rovers_photos_service_impl.dart';
import 'package:nasa_app/src/services/interfaces/rovers_photos_service.dart';

final roversPhotoServiceProvider = Provider<RoversPhotosService>((ref) {
  return RoversPhotosServiceImpl(
    loggerService: ref.read(loggerServiceProvider),
    roversPhotosRemoteDatasource: RoversPhotosRemoteDatasourceImpl(
        api: ref.read(apiProvider), baseUrl: dotenv.env['NASA_URL']!),
  );
});

final roversPhotosProvider = FutureProvider.autoDispose
    .family<List<RoverPhotoItemModel>, RoverNameEnum>(
        (ref, roverNameEnum) async {
  var result =
      await ref.read(roversPhotoServiceProvider).getRoversPhotos(roverNameEnum);
  List<RoverPhotoItemModel> itemList = [];
  result.fold((failure) {
    throw failure;
  }, (photoList) {
    itemList = photoList;
  });
  return itemList;
});
