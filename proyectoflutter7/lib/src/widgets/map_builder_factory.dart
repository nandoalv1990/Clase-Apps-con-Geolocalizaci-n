import 'dart:io' show Platform;
import 'map_builder_base.dart';
import 'android_service.dart';
import 'desktop_service.dart';
import 'web_service.dart';

/*
class MapBuilderFactory {
  static MapBuilderBase create(){
    if (kIsWeb) return MapBuilderWeb();

    if (Platform.isAndroid) return MapBuilderAndroid();
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS){
      return MapBuilderDesktop();
    }
    return MapBuilderAndroid(); // Opción por defecto
  }
}
*/

class MapBuilderFactory {
  static MapBuilderBase<dynamic, dynamic, dynamic, dynamic> create() {
    if (Platform.isAndroid) {
      return MapBuilderAndroid();
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return MapBuilderDesktop();
    } else {
      return MapBuilderWeb();
    }
  }
}
