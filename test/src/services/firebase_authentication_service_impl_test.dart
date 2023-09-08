import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app/src/errors/failures/authentication_failures.dart';
import 'package:nasa_app/src/errors/failures/base_failure.dart';
import 'package:nasa_app/src/errors/failures/unknown_failure.dart';
import 'package:nasa_app/src/services/implementations/firebase_authentication_service_impl.dart';
import 'package:nasa_app/src/services/interfaces/logger_service.dart';

class MockLoggerService extends Mock implements LoggerService {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late FirebaseAuthenticationServiceImpl service;
  late MockLoggerService mockLoggerService;
  late MockFirebaseAuth mockFirebaseAuth;

  setUpAll(() {
    registerFallbackValue(const BaseFailure(message: 'failure'));
  });

  setUp(() {
    mockLoggerService = MockLoggerService();
    mockFirebaseAuth = MockFirebaseAuth();
    service = FirebaseAuthenticationServiceImpl(mockLoggerService);
  });

  group('anonymousSignIn', () {
    final tUserCredential = MockUserCredential();

    test('should sign in anonymously and return Right(unit) on success',
        () async {
      // Arrange
      when(() => mockFirebaseAuth.signInAnonymously())
          .thenAnswer((_) async => tUserCredential);

      // Act
      final result = await service.anonymousSignIn();

      // Assert
      expect(result, const Right(unit));
      verifyNoMoreInteractions(mockLoggerService);
    });

    test(
        'should return FirebaseAnonymousSignInNotAllowedFailure on operation-not-allowed error',
        () async {
      // Arrange
      when(() => mockFirebaseAuth.signInAnonymously())
          .thenThrow(FirebaseAuthException(
        code: 'operation-not-allowed',
        message: 'Anonymous sign-in is not allowed.',
      ));

      // Act
      final result = await service.anonymousSignIn();

      // Assert
      final expectedFailure = FirebaseAnonymousSignInNotAllowedFailure(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      );
      expect(result, Left(expectedFailure));
      verify(() => mockLoggerService.logFailure(failure: expectedFailure))
          .called(1);
    });

    test('should return FirebaseAnonymousSignInUnknownFailure on other errors',
        () async {
      // Arrange
      when(() => mockFirebaseAuth.signInAnonymously())
          .thenThrow(FirebaseAuthException(
        code: 'other-error',
        message: 'An error occurred.',
      ));

      // Act
      final result = await service.anonymousSignIn();

      // Assert
      final expectedFailure = FirebaseAnonymousSignInUnknownFailure(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      );
      expect(result, Left(expectedFailure));
      verify(() => mockLoggerService.logFailure(failure: expectedFailure))
          .called(1);
    });

    test('should return UnknownFailure on generic exceptions', () async {
      // Arrange
      when(() => mockFirebaseAuth.signInAnonymously()).thenThrow(Exception());

      // Act
      final result = await service.anonymousSignIn();

      // Assert
      final expectedFailure = UnknownFailure(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      );
      expect(result, Left(expectedFailure));
      verify(() => mockLoggerService.logFailure(failure: expectedFailure))
          .called(1);
    });
  });
}
