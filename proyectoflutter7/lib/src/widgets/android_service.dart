import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyectoflutter7/src/splash_page.dart';

class MapBuilderAndroid implements MapBuilderBase {
  @override
  Widget buildMap({
    required Functi(GoogleMapController) onMapCreated,
    required Function(LatLng) onTap,
    required set<Marker> markers,
    required Set<Polyline> polylines,
    required LatLng initialPosition,
  }){
    return GoogleMap(initialCameraPosition: CameraPosition(
      target: initialPosition,
      zoom: 14,
    ),
    markers: markers,
    polylines: polylines,
    myLocationButtonEnabled: true,
    onMapCreated: onMapCreated,
    onTap: onTap,
    );
  }
  
}