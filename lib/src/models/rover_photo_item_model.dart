import 'package:equatable/equatable.dart';
import 'package:nasa_app/src/models/rover_model.dart';

class RoverPhotoItemModel extends Equatable {
  final int id;
  final int sol;
  final String imgSrc;
  final String earthDate;
  final String cameraName;
  final RoverModel rover;

  const RoverPhotoItemModel({
    required this.id,
    required this.sol,
    required this.imgSrc,
    required this.earthDate,
    required this.cameraName,
    required this.rover,
  });

  factory RoverPhotoItemModel.fromJson(Map<String, dynamic> json) {
    return RoverPhotoItemModel(
      id: json['id'],
      sol: json['sol'],
      imgSrc: json['img_src'],
      earthDate: json['earth_date'],
      cameraName: json['camera']['name'],
      rover: RoverModel.fromJson(json['rover']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        sol,
        imgSrc,
        earthDate,
        cameraName,
        rover,
      ];
}
