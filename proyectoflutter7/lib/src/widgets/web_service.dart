import 'package:flutter/material.dart';
import 'map_builder_base.dart';

class MapBuilderWeb
    implements MapBuilderBase<Offset, Object, Object, Object> {
  @override
  Widget buildMap({
    required void Function(Object) onMapCreated,
    required void Function(Offset) onTap,
    required Set<Object> markers,
    required Set<Object> polylines,
    required Offset initialCameraPosition,
  }) {
    final controller = Object();
    onMapCreated(controller);
    return GestureDetector(
      onTapDown: (details) => onTap(details.localPosition),
      child: const Center(child: Text('Mapa Web Placeholder')),
    );
  }
}
