import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/models.dart';

// import 'package:flutter_app_cap9/models/models.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  MapType mapType = MapType.hybrid;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLanLng(),
      zoom: 17,
    );

    Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
          markerId: const MarkerId('initial'),
          position: scan.getLanLng(),
          infoWindow: const InfoWindow(title: 'hola')),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('text'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLanLng(),
                    zoom: 17,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: GoogleMap(
        markers: markers,
        mapType: mapType,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapType == MapType.hybrid
              ? mapType = MapType.normal
              : mapType = MapType.hybrid;
          setState(() {});
        },
        child: const Icon(Icons.layers),
      ),
    );
  }
}
