import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nasa_app/errors/failures/base_failure.dart';

abstract interface class FirebaseAuthenticationService {
  Future<Either<BaseFailure, UserCredential>> anonymousSignIn();
}
