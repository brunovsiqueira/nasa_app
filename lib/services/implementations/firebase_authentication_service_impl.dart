import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nasa_app/errors/failures/authentication_failures.dart';
import 'package:nasa_app/errors/failures/base_failure.dart';
import 'package:nasa_app/services/interfaces/firebase_authentication_service.dart';
import 'package:nasa_app/services/interfaces/logger_service.dart';

class FirebaseAuthenticationServiceImpl
    implements FirebaseAuthenticationService {
  final LoggerService _loggerService;

  FirebaseAuthenticationServiceImpl(this._loggerService);

  @override
  Future<Either<BaseFailure, UserCredential>> anonymousSignIn() async {
    BaseFailure? failure;
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      return Right(userCredential);
    } on FirebaseAuthException catch (e, stackTrace) {
      switch (e.code) {
        case "operation-not-allowed":
          failure = FirebaseAnonymousSignInNotAllowedFailure(
            exception: e,
            stackTrace: stackTrace,
          );
          break;
        default:
          failure = FirebaseAnonymousSignInUnknownFailure(
            exception: e,
            stackTrace: stackTrace,
          );
      }
    } catch (e, stackTrace) {
      failure = FirebaseAnonymousSignInUnknownFailure(
        exception: e,
        stackTrace: stackTrace,
      );
    }
    _loggerService.logFailure(failure: failure);
    return Left(failure);
  }
}
