import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../splash_page.dart'; // Para usar MapBuilderBase

class MapBuilderAndroid implements MapBuilderBase {
  @override
  // Ajustar clase a la interfaz
  Widget buildMap({
    required LatLng initialCameraPosition,
    required Set<dynamic> markers,
    required Set<dynamic> polylines,
    required Function onMapCreated,
    required Function onTap,
  }){
    return GoogleMap(
      onMapCreated:(controller) => onMapCreated(controller),
      initialCameraPosition: CameraPosition(
        target: initialCameraPosition,
        zoom: 14,
      ),
      markers: markers.cast<Marker>(),
      polylines: polylines.cast<Polyline>(),
      myLocationEnabled: false,
      onTap:(LatLng) => onTap(LatLng),
    );
  }
}