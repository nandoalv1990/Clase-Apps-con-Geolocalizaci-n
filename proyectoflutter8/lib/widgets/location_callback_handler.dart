import 'dart:isolate';
import 'package:background_locator_2/location_dto.dart';
import 'db_helper.dart';

class LocationCallBackHandler {
  static Future<void> initCallback(Map<dynamic, dynamic> params) async {}
  static Future<void> disposeCallback() async {}
  static Future<void> callback (LocationDto locationDto) async {
    await DBHelper.instance.insertPunto({
      'lat': locationDto.latitude,
      'lng': locationDto.longitude
    });
  }
}