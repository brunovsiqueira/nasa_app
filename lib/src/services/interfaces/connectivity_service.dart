import 'package:dartz/dartz.dart';
import 'package:nasa_app/src/errors/failures/base_failure.dart';

abstract interface class ConnectivityService {
  Future<Either<BaseFailure, bool>> isConnected();
}
