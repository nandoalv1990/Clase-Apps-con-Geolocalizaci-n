
import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'dart:io' show Platform;

import 'widgets/map_builder_base.dart';
import 'widgets/android_service.dart';
import 'widgets/desktop_service.dart';
import 'widgets/web_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  gmaps.GoogleMapController? _mapController;

  // Posición inicial
  gmaps.LatLng _currentPosition = const gmaps.LatLng(20.527102, -100.8116);

  // (Android)
  final Set<gmaps.Marker> _markers = {};
  final Set<gmaps.Polyline> _polylines = {};

  // Variable genérica para cualquier implementación
  late MapBuilderBase<dynamic, dynamic, dynamic, dynamic> mapService;

  @override
  void initState() {
    super.initState();

    // Detectar plataforma y asignar implementación
    if (Platform.isAndroid) {
      mapService = MapBuilderAndroid();
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      mapService = MapBuilderDesktop();
    } else {
      mapService = MapBuilderWeb();
    }

    _determinePosition();
  }

  // Obtener ubicación actual del usuario
  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      _currentPosition = gmaps.LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa Multiplataforma"),
        backgroundColor: Colors.teal,
      ),
      body: mapService.buildMap(
        onMapCreated: (controller) {
          // Android: el controller es GoogleMapController
          if (controller is gmaps.GoogleMapController) {
            _mapController = controller;
          }
        },
        onTap: (point) {
          // Android: point será gmaps.LatLng
          if (point is gmaps.LatLng) {
            setState(() {
              _markers.add(
                gmaps.Marker(
                  markerId: gmaps.MarkerId(point.toString()),
                  position: point,
                ),
              );
            });
          }
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
