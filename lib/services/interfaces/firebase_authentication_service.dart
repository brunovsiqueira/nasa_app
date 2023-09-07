import 'package:dartz/dartz.dart';
import 'package:nasa_app/errors/failures/base_failure.dart';

abstract interface class FirebaseAuthenticationService {
  Future<Either<BaseFailure, Unit>> anonymousSignIn();
}
