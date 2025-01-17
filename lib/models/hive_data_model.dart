import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'hive_data_model.g.dart';

@HiveType(typeId: 0)
class HiveDataModel {
  @HiveField(0)
  int key;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  String time;
  @HiveField(5)
  int priority;
  @HiveField(6)
  bool status;

  HiveDataModel(
      {required this.key,
      required this.name,
      required this.description,
      required this.date,
      required this.time,
      required this.priority,
      required this.status});
}
