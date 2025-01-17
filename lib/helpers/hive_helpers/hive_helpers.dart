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

    print(openBox.values);
    return data;
  }

  static updateData(index, HiveDataModel hiveDataModel) async {
    var openBox = await Hive.openBox<HiveDataModel>("Todo");

    int key = await openBox.keyAt(index);
    openBox.put(key, hiveDataModel);
  }

  static deleteData(index) async {
    var openBox = await Hive.openBox<HiveDataModel>("Todo");

    int key = await openBox.keyAt(index);
    await openBox.delete(key);
  }
}
