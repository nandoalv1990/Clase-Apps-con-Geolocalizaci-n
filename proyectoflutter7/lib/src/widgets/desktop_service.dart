import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fmap;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart' as ll;
import 'map_builder_base.dart';

class MapBuilderDesktop implements MapBuilderBase<ll.LatLng, fmap.Marker, fmap.Polyline, fmap.MapController> {
  @override
  Widget buildMap({
    required void Function(fmap.MapController) onMapCreated,
    required void Function(ll.LatLng) onTap,
    required Set<dynamic> markers,
    required Set<dynamic> polylines,
    required ll.LatLng initialCameraPosition,
  }) {
    final ll.LatLng center = ll.LatLng(
      initialCameraPosition.latitude,
      initialCameraPosition.longitude,
    );
    final mapController = fmap.MapController();

    onMapCreated(mapController);

    // G markers a F markers
    final fmMarkers = markers.cast<gmaps.Marker>().map((m){
      return fmap.Marker(
        width: 40.0,
        height: 40.0,
        point: ll.LatLng(m.position.latitude, m.position.latitude),
        child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
      );
    }).toList();

    // G polylines a F Polylines
    final fmPolylines = polylines.cast<gmaps.Polyline>().map((p){
      return fmap.Polyline(
        strokeWidth: 4.0,
        points: p.points.map((pt) => ll.LatLng(pt.latitude, pt.longitude)).toList(),
        color: Colors.blue,
      );
    }).toList();

    return fmap.FlutterMap(
      mapController: mapController,
      options: fmap.MapOptions(
        initialCenter: initialCameraPosition,
        initialZoom: 14,
        onTap: (tapPosition, point) => onTap(point),
      ),
      children: [
        fmap.TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        fmap.PolylineLayer(polylines: fmPolylines),
        fmap.MarkerLayer(markers: fmMarkers),
      ],
    );
  }
}
