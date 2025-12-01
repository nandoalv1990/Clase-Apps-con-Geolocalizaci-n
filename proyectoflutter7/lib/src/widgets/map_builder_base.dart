import 'package:flutter/material.dart';

// Interfaz genérica
abstract class MapBuilderBase<TLatLng, TMarker, TPolyline, TController> {
  Widget buildMap({
    required void Function(TController controller) onMapCreated,
    required void Function(TLatLng position) onTap,
    required Set<TMarker> markers,
    required Set<TPolyline> polylines,
    required TLatLng initialCameraPosition,
  });
}

/*
// Interfaz neutral
abstract class MapBuilderBase {
  Widget buildMap({
    required Function onMapCreated,
    required Function onTap,
    required Set markers,
    required Set polylines,
    required dynamic initialCameraPosition,
  });
}
*/