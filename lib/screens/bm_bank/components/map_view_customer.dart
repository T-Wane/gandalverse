import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/screens/bm_bank/utils/tile_servers.dart';
import 'package:gandalverse/screens/bm_bank/utils/utils.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class mapView_customer extends StatefulWidget {
  mapView_customer({
   
    required this.userLocation,
    // required CameraPosition initialPosition,
    // required List<Marker> markers,
    // required Completer<GoogleMapController> controller,
    // required this.onTap,
  }); /*: _initialPosition = initialPosition,
        _markers = markers,
        _controller = controller;

  void Function(LatLng position) onTap;
  final CameraPosition _initialPosition;
  final List<Marker> _markers;
  final Completer<GoogleMapController> _controller;*/

  LatLng userLocation;

  @override
  State<mapView_customer> createState() => _mapView_customerState();
}

class _mapView_customerState extends State<mapView_customer> {
  final controller = MapController(
    location: const LatLng(Angle.degree(35.68), Angle.degree(51.41)),
  );

  final markers = [
    const LatLng(Angle.degree(35.674), Angle.degree(51.41)),
    const LatLng(Angle.degree(35.678), Angle.degree(51.41)),
    const LatLng(Angle.degree(35.682), Angle.degree(51.41)),
    const LatLng(Angle.degree(35.686), Angle.degree(51.41)),
  ];

  void _gotoDefault() {
    controller.center = const LatLng(Angle.degree(35.68), Angle.degree(51.41));
    setState(() {});
  }

  void _onDoubleTap(MapTransformer transformer, Offset position) {
    const delta = 0.5;
    final zoom = clamp(controller.zoom + delta, 2, 18);

    transformer.setZoomInPlace(zoom, position);
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      transformer.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  Widget _buildMarkerWidget(Offset pos, Color color,
      [IconData icon = Icons.location_on]) {
    return Positioned(
      left: pos.dx - 24,
      top: pos.dy - 24,
      width: 48,
      height: 48,
      child: GestureDetector(
        child: Icon(
          icon,
          color: color,
          size: 48,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              content: Text('You have clicked a marker!'),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MapLayout(
        controller: controller,
        builder: (context, transformer) {
          // final markerPositions = markers.map(transformer.toOffset).toList();

          // final markerWidgets = markerPositions.map(
          //   (pos) => _buildMarkerWidget(pos, Colors.red),
          // );

          // final homeLocation = transformer
          //     .toOffset(const LatLng(Angle.degree(35.68), Angle.degree(51.42)));

          // final homeMarkerWidget =
          //     _buildMarkerWidget(homeLocation, Colors.black, Icons.home);

          // final centerLocation = Offset(
          //     transformer.constraints.biggest.width / 2,
          //     transformer.constraints.biggest.height / 2);

          // final centerMarkerWidget =
          //     _buildMarkerWidget(centerLocation, Colors.purple);

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTapDown: (details) => _onDoubleTap(
              transformer,
              details.localPosition,
            ),
            onScaleStart: _onScaleStart,
            onScaleUpdate: (details) => _onScaleUpdate(details, transformer),
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  final delta = event.scrollDelta.dy / -1000.0;
                  final zoom = clamp(controller.zoom + delta, 2, 18);

                  transformer.setZoomInPlace(zoom, event.localPosition);
                  setState(() {});
                }
              },
              child: Stack(
                children: [
                  TileLayer(
                    builder: (context, x, y, z) {
                      final tilesInZoom = pow(2.0, z).floor();

                      while (x < 0) {
                        x += tilesInZoom;
                      }
                      while (y < 0) {
                        y += tilesInZoom;
                      }

                      x %= tilesInZoom;
                      y %= tilesInZoom;

                      return CachedNetworkImage(
                        imageUrl: google(z, x, y),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  // homeMarkerWidget,
                  // ...markerWidgets,
                  // centerMarkerWidget,
                ],
              ),
            ),
          );
        });
  }
}
