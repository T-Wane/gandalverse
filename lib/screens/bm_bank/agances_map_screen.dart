import 'dart:async';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/rounded_btn_back.dart';
import 'package:gandalverse/screens/bm_bank/components/actions_sheet.dart';
import 'package:gandalverse/screens/bm_bank/modeles/agence.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlng/latlng.dart';

import 'components/agence_item.dart';
import 'components/driver_details.dart';
import 'components/agences_list_sheet.dart';
import 'components/map_view_customer.dart';
import 'data/agences_list.dart';

class BndaAgenceMapScreen extends StatefulWidget {
  const BndaAgenceMapScreen({Key? key}) : super(key: key);
  @override
  _HomePageFroAllState createState() => _HomePageFroAllState();
}

class _HomePageFroAllState extends State<BndaAgenceMapScreen> {
  LatLng userLocation = LatLng(Angle.degree(0.0), Angle.degree(0.0));

  // List<Marker> _markers = [];
  // BitmapDescriptor? _taxiIcon;

  // void _loadTaxiIcon() async {
  //   final BitmapDescriptor taxiIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(devicePixelRatio: 2.5), Images.taxi,
  //       mipmaps: false);
  //   setState(() {
  //     _taxiIcon = taxiIcon;
  //   });
  // }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR: " + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  Future<void> locateUser() async {
    Position position = await getUserCurrentLocation();

    setState(() {
      userLocation = LatLng(
          Angle.degree(position.latitude), Angle.degree(position.longitude));
      // _markers.add(
      //   Marker(
      //     markerId: MarkerId('currentLocation'),
      //     position: LatLng(position.latitude, position.longitude),
      //     infoWindow: InfoWindow(
      //       title: 'Your Location',
      //     ),
      //   ),
      // );
    });

    // CameraPosition cameraPosition = CameraPosition(
    //   target: LatLng(position.latitude, position.longitude),
    //   zoom: 14.4746,
    // );

    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // Adding markers in a 5km radius around the user's location
    //addMarkersAround(position);
  }

  Future<void> zoomOnAgence(Agence agence) async {
    // if (agence.lat != null && agence.long != null) {
    //   CameraPosition cameraPosition = CameraPosition(
    //     target: LatLng(agence.lat!, agence.long!),
    //     zoom: 14.4746,
    //   );

    //   final GoogleMapController controller = await _controller.future;
    //   controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    // }
  }

  @override
  void initState() {
    super.initState();
    locateUser();
    // _loadTaxiIcon();
  }

  bool findAllAgences = false;
  bool nearbyAngences = false;
  bool showAgenceDetails = false;

  annulerProche() {
    setState(() {
      nearbyAngences = false;
    });
  }

  annulerAlll() {
    setState(() {
      findAllAgences = false;
    });
  }

  TrouverAllAgences() {
    setState(() {
      nearbyAngences = false;
      findAllAgences = true;
    });
  }

  TrouverNearByAgences() {
    setState(() {
      nearbyAngences = true;
      findAllAgences = false;
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          mapView_customer(
            userLocation: userLocation,
            // initialPosition: _initialPosition,
            // markers: _markers,
            // controller: _controller,
            // onTap: (LatLng position) {}
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: BtnRoundedIconBack(
                couleur: Themecolors.Color3,
                onpress: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Visibility(
            visible: nearbyAngences,
            child: AgencesListSheet(
                title: "Agences Proche de vous",
                agences: bndaAgences,
                close: annulerProche,
                zoomOnAgence: zoomOnAgence),
          ),
          Visibility(
            visible: findAllAgences,
            child: AgencesListSheet(
                title: "Toutes nos Agences",
                agences: bndaAgences,
                close: annulerAlll,
                zoomOnAgence: zoomOnAgence),
          ),
          Visibility(
              visible: !nearbyAngences && !findAllAgences && !showAgenceDetails,
              child: Positioned(
                bottom: 0,
                left: 2.0,
                right: 2.0,
                child: ActionsSheet(
                  setAllAgences: TrouverAllAgences,
                  setNearByAgences: TrouverNearByAgences,
                ),
              ))
        ]),
      ),
    );
  }
}
