import 'dart:convert';
import 'package:dio/dio.dart';
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
  const baseUrl = 'https://api.nasa.gov';
  const roverNameEnum = RoverNameEnum.curiosity;
  final url = '$baseUrl/mars-photos/api/v1/rovers/${roverNameEnum.name}/photos';
  String apiKey = 'apiKey';
  final queryParams = {
    'sol': 1000,
    'api_key': apiKey,
  };

  final datasource = RoversPhotosRemoteDatasourceImpl(
      api: mockAPI, baseUrl: baseUrl, apiKey: apiKey);

  final Map<String, dynamic> jsonMap =
      jsonDecode(fixture('rovers_photos_response.json'));

  final requestOptions = RequestOptions(path: url);

  final successfulResponse =
      Response(data: jsonMap, requestOptions: requestOptions);

  void setUpSuccessfulAPICall() {
    when(() => mockAPI.httpGet(
        url: any(named: 'url'),
        queryParams: any(named: 'queryParams'))).thenAnswer(
      (_) async => successfulResponse,
    );
  }

  group('getRoversPhotos', () {
    test('should perform a GET request on the URL', () async {
      // Arrange
      setUpSuccessfulAPICall();

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
      setUpSuccessfulAPICall();

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
