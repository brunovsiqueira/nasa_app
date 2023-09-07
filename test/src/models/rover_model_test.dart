import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_app/src/enums/rover_status_enum.dart';
import 'package:nasa_app/src/models/rover_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  group('RoverModel.fromJson', () {
    test('should return a valid RoverModel', () {
      // Arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('rover.json'));

      final tRover = RoverModel(
        id: 5,
        name: "Curiosity",
        landingDate: "2012-08-06",
        launchDate: "2011-11-26",
        status: RoverStatusEnum.active,
      );

      // Act
      final result = RoverModel.fromJson(jsonMap);

      // Assert
      expect(result, equals(tRover));
    });
  });
}
