import 'package:dartz/dartz.dart';
import 'package:nasa_app/src/errors/failures/base_failure.dart';

abstract interface class FirebaseAuthenticationService {
  Future<Either<BaseFailure, Unit>> anonymousSignIn();
}
