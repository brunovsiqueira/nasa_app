import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nasa_app/src/errors/failures/authentication_failures.dart';
import 'package:nasa_app/src/errors/failures/base_failure.dart';
import 'package:nasa_app/src/errors/failures/unknown_failure.dart';
import 'package:nasa_app/src/services/interfaces/authentication_service.dart';
import 'package:nasa_app/src/services/interfaces/logger_service.dart';

class FirebaseAuthenticationServiceImpl implements AuthenticationService {
  final LoggerService _loggerService;

  FirebaseAuthenticationServiceImpl(this._loggerService);

  @override
  Future<Either<BaseFailure, Unit>> anonymousSignIn() async {
    BaseFailure? failure;
    try {
      await FirebaseAuth.instance.signInAnonymously();
      return const Right(unit);
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
      failure = UnknownFailure(
        exception: e,
        stackTrace: stackTrace,
      );
    }
    _loggerService.logFailure(failure: failure);
    return Left(failure);
  }
}
