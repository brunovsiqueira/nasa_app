import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app/src/datasources/interfaces/rovers_photos_remote_datasource.dart';
import 'package:nasa_app/src/enums/rover_name_enum.dart';
import 'package:nasa_app/src/errors/exceptions/rovers_photos_exceptions.dart';
import 'package:nasa_app/src/errors/failures/base_failure.dart';
import 'package:nasa_app/src/errors/failures/rovers_photos_failures.dart';
import 'package:nasa_app/src/errors/failures/unknown_failure.dart';
import 'package:nasa_app/src/models/rover_photo_item_model.dart';
import 'package:nasa_app/src/services/implementations/rovers_photos_service_impl.dart';
import 'package:nasa_app/src/services/interfaces/logger_service.dart';

import '../../fixtures/fixture_reader.dart';

class MockLoggerService extends Mock implements LoggerService {}

class MockRoversPhotosRemoteDatasource extends Mock
    implements RoversPhotosRemoteDatasource {}

class BaseFailureFake extends Fake implements BaseFailure {}

void main() {
  late RoversPhotosServiceImpl service;
  late MockLoggerService mockLoggerService;
  late MockRoversPhotosRemoteDatasource mockRoversPhotosRemoteDatasource;
  const tRoverName = RoverNameEnum.curiosity;
  DioException tDioException =
      DioException(requestOptions: RequestOptions(baseUrl: ''));

  setUpAll(() {
    registerFallbackValue(BaseFailureFake);
    registerFallbackValue(tRoverName);
  });

  setUp(() {
    mockLoggerService = MockLoggerService();
    mockRoversPhotosRemoteDatasource = MockRoversPhotosRemoteDatasource();
    service = RoversPhotosServiceImpl(
      loggerService: mockLoggerService,
      roversPhotosRemoteDatasource: mockRoversPhotosRemoteDatasource,
    );
  });

  group('getRoversPhotos', () {
    final List<RoverPhotoItemModel> tRoverPhotos =
        jsonDecode(fixture('rovers_photos_response.json'))['photos']
            .map((model) => RoverPhotoItemModel.fromJson(model));

    test('should call RoversPhotosRemoteDatasource.getRoversPhotos once',
        () async {
      // Arrange
      when(() => mockRoversPhotosRemoteDatasource.getRoversPhotos(tRoverName))
          .thenAnswer((_) async => tRoverPhotos);

      // Act
      await service.getRoversPhotos(tRoverName);

      // Assert
      verify(() => mockRoversPhotosRemoteDatasource.getRoversPhotos(tRoverName))
          .called(1);
      verifyZeroInteractions(mockLoggerService);
    });

    test('should return a list of RoverPhotoItemModel on success', () async {
      // Arrange
      when(() => mockRoversPhotosRemoteDatasource.getRoversPhotos(tRoverName))
          .thenAnswer((_) async => tRoverPhotos);

      // Act
      final result = await service.getRoversPhotos(tRoverName);

      // Assert
      expect(result, Right(tRoverPhotos));
    });

    test(
        'should call LoggerService.logFailure and return GetRoversPhotosFailure on GetRoversPhotosException',
        () async {
      // Arrange
      final tException = GetRoversPhotosException(dioException: tDioException);
      when(() => mockRoversPhotosRemoteDatasource.getRoversPhotos(tRoverName))
          .thenThrow(tException);

      // Act
      final result = await service.getRoversPhotos(tRoverName);

      // Assert
      final tExpectedFailure = GetRoversPhotosFailure(
        exception: tException,
      );
      verify(() => mockLoggerService.logFailure(failure: tExpectedFailure))
          .called(1);
      expect(result, Left(tExpectedFailure));
    });

    test(
        'should call LoggerService.logFailure and return UnknownFailure on generic Exception',
        () async {
      // Arrange
      final tException = Exception('An error occurred');
      when(() => mockRoversPhotosRemoteDatasource.getRoversPhotos(tRoverName))
          .thenThrow(tException);

      // Act
      final result = await service.getRoversPhotos(tRoverName);

      // Assert
      final tExpectedFailure = UnknownFailure(
        exception: tException,
      );
      verify(() => mockLoggerService.logFailure(failure: tExpectedFailure))
          .called(1);
      expect(result, Left(tExpectedFailure));
    });
  });
}
