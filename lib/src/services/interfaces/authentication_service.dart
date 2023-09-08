import 'package:dartz/dartz.dart';
import 'package:nasa_app/src/errors/failures/base_failure.dart';

abstract interface class AuthenticationService {
  Future<Either<BaseFailure, Unit>> anonymousSignIn();
}
