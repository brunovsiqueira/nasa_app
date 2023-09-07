import 'package:flutter/material.dart';

enum RoverStatusEnum {
  active(icon: Icon(Icons.circle), description: "Operating"),
  complete(icon: Icon(Icons.done), description: "Complete");

  const RoverStatusEnum({required this.icon, required this.description});

  final Icon icon;
  final String description;
}
