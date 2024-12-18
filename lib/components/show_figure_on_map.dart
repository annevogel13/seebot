import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneShowMap extends StatefulWidget {
  const PolygoneShowMap({super.key});

  @override
  State<PolygoneShowMap> createState() => _PolygoneShowMapState();
}

class _PolygoneShowMapState extends State<PolygoneShowMap> {
  // created controller to display Google Maps
  final Completer<GoogleMapController> _controller = Completer();

  // on below line we have set the camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(19.0759837, 72.8776559),
    zoom: 14,
  );

  final Set<Polygon> _polygon = HashSet<Polygon>();

// created list of locations to display polygon
  List<LatLng> points = [
    LatLng(19.0759837, 72.8776559),
    LatLng(28.679079, 77.069710),
    LatLng(26.850000, 80.949997),
    LatLng(19.0759837, 72.8776559),
  ];

  @override
  void initState() {
    super.initState();
    //initialize polygon
    _polygon.add(Polygon(
      polygonId: PolygonId('1'),
      points: points,
      fillColor: Colors.green.withValues(alpha: 0.3),
      strokeColor: Colors.green,
      geodesic: true,
      strokeWidth: 4,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        //given camera position
        initialCameraPosition: _kGoogle,
        // on below line we have given map type
        mapType: MapType.normal,
        // on below line we have enabled location
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        // on below line we have enabled compass location
        compassEnabled: true,
        // on below line we have added polygon
        polygons: _polygon,
        // displayed google map
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
