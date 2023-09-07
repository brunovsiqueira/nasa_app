import 'package:nasa_app/models/rover_model.dart';

class RoverItemModel {
  final int id;
  final int sol;
  final String imgSrc;
  final String earthDate;
  final String cameraName;
  final RoverModel rover;

  RoverItemModel({
    required this.id,
    required this.sol,
    required this.imgSrc,
    required this.earthDate,
    required this.cameraName,
    required this.rover,
  });

  factory RoverItemModel.fromJson(Map<String, dynamic> json) {
    return RoverItemModel(
      id: json['id'],
      sol: json['sol'],
      imgSrc: json['img_src'],
      earthDate: json['earth_date'],
      cameraName: json['camera']['name'],
      rover: RoverModel.fromJson(json['rover']),
    );
  }
}
