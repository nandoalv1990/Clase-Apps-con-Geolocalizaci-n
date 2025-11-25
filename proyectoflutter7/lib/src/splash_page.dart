import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

import 'widgets/android_service.dart';
import 'widgets/desktop_service.dart';
import 'widgets/web_service.dart';
//import 'package:flutter/widgets.dart';

// Clase iniciadora - Conectar con servicios
abstract class MapBuilderBase {
  Widget buildMap({
    required Function onMapCreated,
    required Function onTap,
    required Set markers,
    required Set polylines,
    required LatLng initialCameraPosition,
  });
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
GoogleMapController? _mapController;
//20.527102, -100.8116
LatLng _currentPosition = const LatLng(20.527102, -100.8116);
final Set<Marker> _markers = {};
final Set<Polyline> _polylines = {};

late MapBuilderBase mapService;

  @override
  void initState(){
    super.initState();

    // Detectar plataforma y elige servicio (Deberá moverse a map_builder_factory de preferencia)
    if (Platform.isAndroid){
      mapService = MapBuilderAndroid();
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS){
      //mapService = MapBuilderDesktop();
    }else {
      //mapService = MapBuilderWeb();
    }
    _determinePosition();
  }

  // Obtener ubicación actual del usuario
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Comprobar que el GPS está activo
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled){
      return;
    }

  // Permisos
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied){
    permission == await Geolocator.requestPermission();
    if (permission == LocationPermission.denied){
      return;
    }
  }
  if (permission == LocationPermission.deniedForever){
    return;
  }
  // Obtener posición
  Position position = await Geolocator.getCurrentPosition();

  setState(() {
    _currentPosition = LatLng(position.latitude, position.longitude);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps en Flutter"),
        backgroundColor: Colors.teal,
      ),
      body: mapService.buildMap(
        onMapCreated: (controller) => _mapController = controller, 
        onTap: (LatLng point){
          setState(() {
            _markers.add(
              Marker(
                markerId: MarkerId(point.toString()),
                position: point,
            ),
          );
          });
        }, 
        markers: _markers, 
        polylines: _polylines, 
        initialCameraPosition: _currentPosition,
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: _determinePosition,
        child: const Icon(Icons.my_location),
      ),
    );
  }
  
}