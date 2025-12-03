import 'dart:io';
import 'dart:convert';

/// Uso? Crear un archivo config/app_config.json en la raíz del proyecto con el siguiente contenido:  
///   1. Copiar config/app_config.json.template a config/app_config.json
///   2. Llenar API keys
///   3. Añadir config/app_config.json a .gitignore
///   4. Usar AppConfig.instance.mapTilerKey para obtener la key en tiempo de ejecución.
class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  String _mapTilerKey = '';
  bool _loaded = false;

  AppConfig._internal();

  static AppConfig get instance => _instance;

  /// Cargar desde config/app_config.json o variable de entorno MAPTILER_KEY.
  Future<void> load() async {
    if (_loaded) return;

    try {
      // Cargar config/app_config.json en tiempo de ejecución
      final configFile = File('config/app_config.json');
      if (await configFile.exists()) {
        final contents = await configFile.readAsString();
        final config = jsonDecode(contents) as Map<String, dynamic>;
        _mapTilerKey = config['maptiler_key'] ?? '';
      } else {
        // Variable de entorno como fallback
        _mapTilerKey = Platform.environment['MAPTILER_KEY'] ?? '';
      }
    } catch (e) {
      // En caso de fallo, usar variable de entorno 
      _mapTilerKey = Platform.environment['MAPTILER_KEY'] ?? '';
    }

    _loaded = true;
  }

  /// Obtener la MapTiler Key configurada.
  String get mapTilerKey => _mapTilerKey;
}
