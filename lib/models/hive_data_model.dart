import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'hive_data_model.g.dart';

@HiveType(typeId: 0)
class HiveDataModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  String time;
  @HiveField(4)
  int priority;
  @HiveField(5)
  bool status;

  HiveDataModel(
      {required this.name,
      required this.description,
      required this.date,
      required this.time,
      required this.priority,
      required this.status});
}
