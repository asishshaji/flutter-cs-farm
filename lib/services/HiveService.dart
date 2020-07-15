import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class HiveService {
  static isExists({String boxName}) async {
    final openBox = await Hive.openBox(boxName);

    int length = openBox.length;
    return length != 0;
  }

  static addBoxes<T>(List<T> items, String boxName) async {
    debugPrint("Adding box $boxName");
    final openBox = await Hive.openBox(boxName);
    for (var item in items) {
      openBox.add(item);
    }
  }

  static getBoxes<T>(String boxName) async {
    List<T> boxList = List<T>();
    final openBox = await Hive.openBox(boxName);
    for (int i = 0; i < openBox.length; i++) {
      boxList.add(openBox.getAt(i));
    }
    return boxList;
  }
}
