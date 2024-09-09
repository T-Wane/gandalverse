import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapView_customer extends StatelessWidget {
  mapView_customer({
    super.key,
    required CameraPosition initialPosition,
    required List<Marker> markers,
    required Completer<GoogleMapController> controller,
    required this.onTap,
  })  : _initialPosition = initialPosition,
        _markers = markers,
        _controller = controller;

  void Function(LatLng position) onTap;
  final CameraPosition _initialPosition;
  final List<Marker> _markers;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      markers: Set<Marker>.of(_markers),
      mapType: MapType.terrain,
      myLocationEnabled: true,
      compassEnabled: true, 
      onTap: onTap,
      onMapCreated: (GoogleMapController controller) {
        if (!_controller.isCompleted) {
          _controller.complete(controller);
        } 
      },
    );
  }
}
