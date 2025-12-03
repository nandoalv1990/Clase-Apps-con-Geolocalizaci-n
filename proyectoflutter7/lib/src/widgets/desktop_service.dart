import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fmap;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart' as ll;
import 'map_builder_base.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../config/app_config.dart';

// e.g. `flutter run -d linux --dart-define=MAPTILER_KEY=YOUR_KEY`.

const String kMapTilerKey = String.fromEnvironment('MAPTILER_KEY', defaultValue: '');
class MapBuilderDesktop implements MapBuilderBase<ll.LatLng, fmap.Marker, fmap.Polyline, fmap.MapController> {
  @override
  Widget buildMap({
    required void Function(fmap.MapController) onMapCreated,
    required void Function(ll.LatLng) onTap,
    required Set<dynamic> markers,
    required Set<dynamic> polylines,
    required dynamic initialCameraPosition,
  }) {
    late final ll.LatLng center;
    if (initialCameraPosition is gmaps.LatLng) {
      final gmaps.LatLng pos = initialCameraPosition;
      center = ll.LatLng(pos.latitude, pos.longitude);
    } else if (initialCameraPosition is ll.LatLng) {
      center = initialCameraPosition;
    } else {
      throw Exception('Unsupported LatLng type');
    }

    final mapController = fmap.MapController();
    final fmMarkers = markers.cast<gmaps.Marker>().map((m){
      return fmap.Marker(
        width: 40.0,
        height: 40.0,
        point: ll.LatLng(m.position.latitude, m.position.longitude),
        child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
      );
    }).toList();

    final fmPolylines = polylines.cast<gmaps.Polyline>().map((p){
      return fmap.Polyline(
        strokeWidth: 4.0,
        points: p.points.map((pt) => ll.LatLng(pt.latitude, pt.longitude)).toList(),
        color: Colors.blue,
      );
    }).toList();

    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final packageInfo = snapshot.data;
        final userAgent = packageInfo != null
            ? '${packageInfo.packageName}/${packageInfo.version} (${packageInfo.appName})'
            : 'proyectoflutter7/0.1.0 (nandoalv1990)';

        onMapCreated(mapController);
        // Usar MapTiler key
        final mapTilerKey = AppConfig.instance.mapTilerKey;

        return fmap.FlutterMap(
          mapController: mapController,
          options: fmap.MapOptions(
            initialCenter: center,
            initialZoom: 14,
            onTap: (tapPosition, point) => onTap(point),
          ),
          children: [
            fmap.TileLayer(
              urlTemplate: mapTilerKey.isNotEmpty
                  ? 'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=$mapTilerKey'
                  : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: userAgent,
              additionalOptions: {
                'attribution': mapTilerKey.isNotEmpty
                    ? '© MapTiler © OpenStreetMap contributors'
                    : '© OpenStreetMap contributors'
              },
            ),

            Positioned(
              right: 6,
              bottom: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                child: Text(
                  mapTilerKey.isNotEmpty
                      ? '© MapTiler © OpenStreetMap contributors'
                      : '© OpenStreetMap contributors',
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),

            fmap.PolylineLayer(polylines: fmPolylines),
            fmap.MarkerLayer(markers: fmMarkers),
          ],
        );
      },
    );
  }
}
