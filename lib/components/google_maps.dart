import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seebot/functions/current_location.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;

  CameraPosition? _initialCameraPosition;
  Position? position;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    position = await getCurrentLocation();
    setState(() {
      _initialCameraPosition = CameraPosition(
        target: LatLng(position!.latitude, position!.longitude),
        zoom: 20.0,
      );
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              debugPrint("I WAS TAPPED @ STACK");
            },
            child: GoogleMap(
              initialCameraPosition: _initialCameraPosition ??
                  CameraPosition(
                      target: LatLng(47.500714982217644, 9.741313618968784),
                      zoom: 1),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              markers: {},
              polylines: {},
              onTap: (element) => {debugPrint("I WAS TAPPED")},
            ),
          ),
        ],
      ),
    );
  }
}
