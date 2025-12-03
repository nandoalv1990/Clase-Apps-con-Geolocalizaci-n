import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:latlong2/latlong.dart' as ll;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'map_builder_base.dart';
import '../../config/app_config.dart';

class MapBuilderWeb implements MapBuilderBase<ll.LatLng, dynamic, dynamic, WebViewController?> {
  @override
  Widget buildMap({
    required void Function(WebViewController?) onMapCreated,
    required void Function(ll.LatLng) onTap,
    required Set<dynamic> markers,
    required Set<dynamic> polylines,
    required ll.LatLng initialCameraPosition,
  }) {
    return _MapWebView(
      onMapCreated: onMapCreated,
      onTap: onTap,
      markers: markers,
      initialCameraPosition: initialCameraPosition,
    );
  }
}

class _MapWebView extends StatefulWidget {
  final void Function(WebViewController?) onMapCreated;
  final void Function(ll.LatLng) onTap;
  final Set<dynamic> markers;
  final ll.LatLng initialCameraPosition;

  const _MapWebView({
    Key? key,
    required this.onMapCreated,
    required this.onTap,
    required this.markers,
    required this.initialCameraPosition,
  }) : super(key: key);

  @override
  State<_MapWebView> createState() => _MapWebViewState();
}

class _MapWebViewState extends State<_MapWebView> {
  late final WebViewController _controller;
  String? _html;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('Flutter', onMessageReceived: (message) {
        try {
          final Map<String, dynamic> data = jsonDecode(message.message);
          final lat = (data['lat'] as num).toDouble();
          final lng = (data['lng'] as num).toDouble();
          widget.onTap(ll.LatLng(lat, lng));
        } catch (_) {}
      });

    _loadHtml();
  }

  Future<void> _loadHtml() async {
    final raw = await rootBundle.loadString('assets/map/index.html');
    final key = AppConfig.instance.mapTilerKey;
    final uri = Uri.dataFromString(raw, mimeType: 'text/html', encoding: Utf8Codec());
    final finalUri = uri.replace(queryParameters: {if (key.isNotEmpty) 'key': key});
    setState(() => _html = finalUri.toString());
    await _controller.loadRequest(finalUri);

    widget.onMapCreated(_controller);
    _syncMarkers();
  }

  Future<void> _syncMarkers() async {
    await _controller.runJavaScript('window.clearMarkers && window.clearMarkers();');

    for (final m in widget.markers) {
      if (m is gmaps.Marker) {
        final lat = m.position.latitude;
        final lng = m.position.longitude;
        await _controller.runJavaScript('window.addMarker && window.addMarker($lat, $lng);');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_html == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return WebViewWidget(controller: _controller);
  }
}
