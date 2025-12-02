import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/android_settings.dart';

import 'package:proyectoflutter8/widgets/location_callback_handler.dart';
import 'package:proyectoflutter8/widgets/db_helper.dart';

class RastrearPage extends StatefulWidget {
  const RastrearPage({super.key});

  @override
  State<RastrearPage> createState() => _RastrearPageState();
}

class _RastrearPageState extends State<RastrearPage> {
  Set<gmaps.Marker> markers = {};
  gmaps.GoogleMapController? controller;

  @override
  void initState() {
    super.initState();
    cargarPuntos();
  }

  void cargarPuntos() async {
    final lista =await DBHelper.instance.getPuntos();
    setState(() {
      markers = lista.map((p) => gmaps.Marker(
        markerId: gmaps.MarkerId("${p['id']}"),
        position: gmaps.LatLng(p['lat'], p['lng']),
      )).toSet();
    });
  }
  
  Future<void> iniciarRastreo() async{
    await BackgroundLocator.initialize();

    BackgroundLocator.registerLocationUpdate(
      LocationCallBackHandler.callback,
      initCallback: LocationCallBackHandler.initCallback,
      disposeCallback: LocationCallBackHandler.disposeCallback,
      androidSettings: AndroidSettings(
        interval: 10,
        accuracy: LocationAccuracy.NAVIGATION,
        androidNotificationSettings: AndroidNotificationSettings(
          notificationChannelName: "Rastreo en segundo plano",
          notificationTitle: "Rastreo activo",
          notificationMsg: "La app te sigue",
        )
      ),
      iosSettings: IOSSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        distanceFilter: 0,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}