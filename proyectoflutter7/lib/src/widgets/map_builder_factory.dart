import 'dart:io' show Platform; 
import 'package:flutter/foundation.dart';
import 'package:proyectoflutter7/src/splash_page.dart';
import 'android_service.dart';
import 'desktop_service.dart';
import 'web_service.dart';

class MapBuilderFactory {
  static MapBuilderBase create(){
    if (kIsWeb) return MapBuilderWeb();

    if (Platform.isAndroid) return MapBuilderAndroid();
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS){
      return MapBuilderDesktop();
    }
    return MapBuilderDesktop(); // Defecto
  }
  
}