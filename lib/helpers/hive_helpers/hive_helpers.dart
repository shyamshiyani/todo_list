import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/hive_data_model.dart';

class HiveHelpers {
  static addData(HiveDataModel hiveDataModel) async {
    var openBox = await Hive.openBox<HiveDataModel>("Todo");
    await openBox.add(hiveDataModel);
  }

  static getData() async {
    var openBox = await Hive.openBox<HiveDataModel>("Todo");

    List<HiveDataModel> data = await openBox.values.toList();
    log("=================");
    log("${openBox.keys}");
    log("=================");
    return data;
  }

  static updateData(index, HiveDataModel hiveDataModel) async {
    var openBox = await Hive.openBox<HiveDataModel>("Todo");

    openBox.put(hiveDataModel.key, hiveDataModel);
  }

  static deleteData(key) async {
    var openBox = await Hive.openBox<HiveDataModel>("Todo");

    await openBox.delete(key);
  }
}
