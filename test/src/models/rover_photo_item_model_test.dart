import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_app/src/enums/rover_status_enum.dart';
import 'package:nasa_app/src/models/rover_model.dart';
import 'package:nasa_app/src/models/rover_photo_item_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  group('RoverPhotoItemModel.fromJson', () {
    test('should return a valid RoverPhotoItemModel', () {
      // Arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('rover_photo_item.json'));

      final tRoverPhotoItem = RoverPhotoItemModel(
        id: 102693,
        sol: 1000,
        imgSrc:
            'http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG',
        earthDate: '2015-05-30',
        cameraName: 'FHAZ',
        rover: RoverModel(
          id: 5,
          name: 'Curiosity',
          landingDate: '2012-08-06',
          launchDate: '2011-11-26',
          status: RoverStatusEnum.active,
        ),
      );

      // Act
      final result = RoverPhotoItemModel.fromJson(jsonMap);

      // Assert
      expect(result, equals(tRoverPhotoItem));
    });
  });
}
