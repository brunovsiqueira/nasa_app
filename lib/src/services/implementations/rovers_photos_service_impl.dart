import 'package:dartz/dartz.dart';
import 'package:nasa_app/src/datasources/interfaces/rovers_photos_remote_datasource.dart';
import 'package:nasa_app/src/enums/rover_name_enum.dart';
import 'package:nasa_app/src/errors/exceptions/rovers_photos_exceptions.dart';
import 'package:nasa_app/src/errors/failures/base_failure.dart';
import 'package:nasa_app/src/errors/failures/rovers_photos_failures.dart';
import 'package:nasa_app/src/errors/failures/unknown_failure.dart';
import 'package:nasa_app/src/models/rover_photo_item_model.dart';
import 'package:nasa_app/src/services/interfaces/logger_service.dart';
import 'package:nasa_app/src/services/interfaces/rovers_photos_service.dart';

class RoversPhotosServiceImpl implements RoversPhotosService {
  final LoggerService loggerService;
  final RoversPhotosRemoteDatasource roversPhotosRemoteDatasource;

  RoversPhotosServiceImpl({
    required this.loggerService,
    required this.roversPhotosRemoteDatasource,
  });

  @override
  Future<Either<BaseFailure, List<RoverPhotoItemModel>>> getRoversPhotos(
    RoverNameEnum roverNameEnum,
  ) async {
    BaseFailure? failure;
    try {
      var result =
          await roversPhotosRemoteDatasource.getRoversPhotos(roverNameEnum);
      return Right(result);
    } on GetRoversPhotosException catch (e, stackTrace) {
      failure = GetRoversPhotosFailure(
        exception: e,
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      failure = UnknownFailure(
        exception: e,
        stackTrace: stackTrace,
      );
    }
    loggerService.logFailure(failure: failure);
    return Left(failure);
  }
}
