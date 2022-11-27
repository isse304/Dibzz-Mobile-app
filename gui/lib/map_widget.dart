// Google map widget

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final LatLng _center = const LatLng(44.0262133, -88.5530043);

  void _onMapCreated(GoogleMapController controller) {
    // controller.setMapStyle(Utils.mapStyles);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      // List of markers
      markers: {
        Marker(
          markerId: const MarkerId('marker_1'),
          position: _center,
          infoWindow: const InfoWindow(
            title: 'Marker 1',
            snippet: 'This is a marker',
          ),
        ),
      },
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 10.0,
      ),
    );
  }
}
