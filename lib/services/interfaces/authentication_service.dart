import 'package:dartz/dartz.dart';
import 'package:nasa_app/errors/failures/base_failure.dart';

abstract interface class AuthenticationService {
  Either<BaseFailure, Unit> signIn();
}
