import 'dart:async';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/rounded_btn_back.dart';
import 'package:gandalverse/screens/bnda/components/actions_sheet.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 16,
    bearing: 30,
  );

  List<Marker> _markers = [];
  BitmapDescriptor? _taxiIcon;

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

    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // Adding markers in a 5km radius around the user's location
    //addMarkersAround(position);
  }

  /*void addMarkersAround(Position center) {
    final Random random = Random();
    const double radius = 2000; // 5 km

    for (int i = 0; i < 10; i++) {
      final double angle = random.nextDouble() * 2 * pi;
      final double distance = random.nextDouble() * radius;

      // Calculate new coordinates
      final double dx = distance * cos(angle) / 111320;
      final double dy = distance * sin(angle) / 111320;

      final double newLat = center.latitude + dy;
      final double newLng = center.longitude + dx;

      setState(() {
        _markers.add(
          Marker(
              markerId: MarkerId('taxi_$i'),
              position: LatLng(newLat, newLng),
              icon: _taxiIcon ?? BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: 'Taxi $i',
              ),
              onTap: () {
                setState(() {
                  showTaxiDetails = true;
                  taxiSelectedName = "Chauffeur $i";
                });
              }),
        );
      });
    }
  }*/

  @override
  void initState() {
    super.initState();
    locateUser();
    // _loadTaxiIcon();
  }

  bool findAllAgences = false;
  bool nearbyAngences = false;
  bool showAgenceDetails = false;
  // void _onTap(LatLng position) {
  //   setState(() {
  //     _markers.removeWhere(
  //         (element) => element.infoWindow.title == "Position choisie");
  //     // Efface les anciens marqueurs si vous souhaitez en avoir un seul à la fois
  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId(position.toString()),
  //         position: position,
  //         infoWindow: InfoWindow(
  //           title: 'Position choisie',
  //           snippet: '${position.latitude}, ${position.longitude}',
  //         ),
  //         icon: BitmapDescriptor.defaultMarker,
  //       ),
  //     );
  //     pinIsPlaced = true;
  //   });
  // }

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
      // appBar: AppBar(
      //   surfaceTintColor: ThemeColors.white,
      //   backgroundColor: ThemeColors.white,
      //   elevation: 0.2,
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   leadingWidth: 100,
      //   leading: CustomImageView(
      //     imagePath: Images.logo_paysage,
      //     fit: BoxFit.contain,
      //     margin: const EdgeInsets.symmetric(horizontal: 5),
      //   ),
      //   actions: [

      //   ],
      // ),
      body: SafeArea(
        child: Stack(children: [
          mapView_customer(
              initialPosition: _initialPosition,
              markers: _markers,
              controller: _controller,
              onTap: (LatLng position) {}),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: BtnRoundedIconBack(
                couleur: Themecolors.Color3,
                onpress: () {
                  context.pop();
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
            ),
          ),
          Visibility(
            visible: findAllAgences,
            child: AgencesListSheet(
              title: "Agences Proche de vous",
              agences: bndaAgences,
              close: annulerAlll,
            ),
          ),
          // Visibility(
          //   visible: pinIsPlaced,
          //   child: doYouWantDriver(
          //       annulerPlacePin: annulerPlacePin,
          //       TrouverChauffeur: TrouverChauffeur),
          // ),

          // Visibility(
          //   visible: showTaxiDetails,
          //   child: driverDetails(
          //       driverName: taxiSelectedName,
          //       close: () {
          //         setState(() {
          //           showTaxiDetails = !showTaxiDetails;
          //           taxiSelectedName = "";
          //         });
          //       }),
          // ),

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

          //driverListSheet(),
        ]),
      ),
    );
  }
}
