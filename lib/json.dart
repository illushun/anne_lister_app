import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

Future<void> getJsonData(String jsonPath, List storeData) async {
  final String response = await rootBundle.loadString(jsonPath);
  final data = await json.decode(response);
  storeData = data["events"];
}

class EventData {
  String date;
  EventData({required this.date});
}

class ReadJson {
  Map _jsonData = {};

  ReadJson();

  dynamic getData(String key) {
    print(_jsonData);
    return _jsonData[key];
  }

  Future<void> initData(String key, String jsonPath) async {
    final String response = await rootBundle.loadString(jsonPath);
    _jsonData[key] = json.decode(response);
  }
}
