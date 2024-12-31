import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seebot/models/areas.dart';

class PolygoneShowMap extends StatefulWidget {
  const PolygoneShowMap({super.key, required this.area});

  final Area area;

  @override
  State<PolygoneShowMap> createState() => _PolygoneShowMapState();
}

class _PolygoneShowMapState extends State<PolygoneShowMap> {
  // created controller to display Google Maps
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Polygon> _polygon = HashSet<Polygon>();

  @override
  void initState() {
    super.initState();

    //initialize points
    final List<LatLng> points =
        widget.area.getCoordinates.map((e) => LatLng(e[0], e[1])).toList();

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
        initialCameraPosition: CameraPosition(
            target: widget.area.centerCoordinates, zoom: widget.area.zoomLevel),
        // on below line we have given map type
        mapType: MapType.satellite,
        // on below line we have enabled location
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
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
