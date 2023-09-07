import 'package:nasa_app/src/enums/rover_status_enum.dart';

class RoverModel {
  final int id;
  final String name;
  final String landingDate;
  final String launchDate;
  final RoverStatusEnum status;

  RoverModel({
    required this.id,
    required this.name,
    required this.landingDate,
    required this.launchDate,
    required this.status,
  });

  factory RoverModel.fromJson(Map<String, dynamic> json) {
    return RoverModel(
      id: json['id'],
      name: json['name'],
      landingDate: json['landing_date'],
      launchDate: json['launch_date'],
      status: RoverStatusEnum.values.byName(json['status']),
    );
  }
}
