import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'map_builder_base.dart';

class MapBuilderAndroid
    implements MapBuilderBase<gmaps.LatLng, gmaps.Marker, gmaps.Polyline, gmaps.GoogleMapController> {
  @override
  Widget buildMap({
    required void Function(gmaps.GoogleMapController) onMapCreated,
    required void Function(gmaps.LatLng) onTap,
    required Set<gmaps.Marker> markers,
    required Set<gmaps.Polyline> polylines,
    required gmaps.LatLng initialCameraPosition,
  }) {
    return gmaps.GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: gmaps.CameraPosition(target: initialCameraPosition, zoom: 14),
      markers: markers,
      polylines: polylines,
      myLocationButtonEnabled: true,
      myLocationEnabled: false,
      onTap: onTap,
    );
  }
}
