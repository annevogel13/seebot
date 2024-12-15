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
  // Google Maps Controller
  GoogleMapController? _mapController;

  // Markers and Polylines
  final Set<Marker> _markers = {};
  //final List<LatLng> _polylinePoints = [];
  final Set<Polyline> _polylines = {};

  // Initial Location (Center of the Map)
  CameraPosition? _initialCameraPosition; // users location
  Position? position ; 

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    // Get user locationflutt
    position = await getCurrentLocation();
    //print("Position :");
    //print(position!.latitude + position!.longitude); 
    // Add a marker for the user location
      setState(() {
        _initialCameraPosition = CameraPosition(
          target: LatLng(position!.latitude, position!.longitude),
          zoom: 20.0, // Maximum zoom level
        );
      });

    // Add a polyline to the user location
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(47.500714982217644, 9.741313618968784), zoom: 1),
          onMapCreated: (controller) {
            _mapController = controller;
          },
          markers: _markers,
          polylines: _polylines,
          onTap: (element) {}, // Handle user tap on the map
        ),
      ],
    ));
  }
}
