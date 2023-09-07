import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:nasa_app/errors/failures/base_failure.dart';
import 'package:nasa_app/errors/failures/connectivity_failures.dart';
import 'package:nasa_app/services/interfaces/connectivity_service.dart';
import 'package:nasa_app/services/interfaces/logger_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  final LoggerService _loggerService;
  final InternetConnection internetConnection;

  ConnectivityServiceImpl(
    this._loggerService,
    this.internetConnection,
  );

  @override
  Future<Either<BaseFailure, bool>> isConnected() async {
    BaseFailure? failure;
    try {
      return Right(await internetConnection.hasInternetAccess);
    } catch (e, stackTrace) {
      failure = ConnectivityHasInternetAccessFailure(
        exception: e,
        stackTrace: stackTrace,
      );
      _loggerService.logFailure(failure: failure);
    }
    return Left(failure);
  }
}
