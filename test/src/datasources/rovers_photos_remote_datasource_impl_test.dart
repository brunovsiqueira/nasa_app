import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app/src/datasources/implementations/rovers_photos_remote_datasource_impl.dart';
import 'package:nasa_app/src/enums/rover_name_enum.dart';
import 'package:nasa_app/src/errors/exceptions/rovers_photos_exceptions.dart';
import 'package:nasa_app/src/models/rover_photo_item_model.dart';
import 'package:nasa_app/src/network/interfaces/api.dart';

import '../../fixtures/fixture_reader.dart';

class MockAPI extends Mock implements API {}

void main() {
  final mockAPI = MockAPI();
  const baseUrl = 'https://api.nasa.gov/mars-photos';

  final datasource =
      RoversPhotosRemoteDatasourceImpl(api: mockAPI, baseUrl: baseUrl);

  setUp(() async {
    await dotenv.load(fileName: '../../test/fixtures/.test.env');
  });

  group('getRoversPhotos', () {
    test('should perform a GET request on the URL', () async {
      // Arrange
      const roverNameEnum = RoverNameEnum.curiosity;
      final url = '$baseUrl/api/v1/rovers/${roverNameEnum.name}/photos';
      final queryParams = {
        'sol': 1000,
        'api_key': 'your_api_key', // Replace with your actual API key
      };
      final requestOptions = RequestOptions(path: url);

      when(() => mockAPI.httpGet(
          url: any(named: 'url'),
          queryParams: any(named: 'queryParams'))).thenAnswer(
        (_) async => Response(
          data: jsonDecode(fixture('rover_photos_response.json')),
          requestOptions: requestOptions,
        ),
      );

      // Act
      await datasource.getRoversPhotos(roverNameEnum);

      // Assert
      verify(() => mockAPI.httpGet(url: url, queryParams: queryParams))
          .called(1);
    });

    test('should return a list of RoverPhotoItemModel on a successful API call',
        () async {
      // Arrange
      const roverNameEnum = RoverNameEnum.curiosity;
      final url = '$baseUrl/api/v1/rovers/${roverNameEnum.name}/photos';

      when(() => mockAPI.httpGet(
          url: any(named: 'url'),
          queryParams: any(named: 'queryParams'))).thenAnswer(
        (_) async => Response(
          data: jsonDecode(fixture('rover_photos_response.json')),
          requestOptions: RequestOptions(path: url),
        ),
      );

      // Act
      final result = await datasource.getRoversPhotos(roverNameEnum);

      // Assert
      expect(result, isA<List<RoverPhotoItemModel>>());
    });

    test('should throw GetRoversPhotosException on DioException', () async {
      // Arrange
      const roverNameEnum = RoverNameEnum.curiosity;
      final requestOptions = RequestOptions(path: baseUrl);

      when(() => mockAPI.httpGet(
          url: any(named: 'url'),
          queryParams: any(named: 'queryParams'))).thenThrow(DioException(
        requestOptions: requestOptions,
      ));

      // Act
      final call = datasource.getRoversPhotos;

      // Assert
      expect(
        () async => await call(roverNameEnum),
        throwsA(isA<GetRoversPhotosException>()),
      );
    });
  });
}
