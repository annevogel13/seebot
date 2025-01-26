import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'custom_marker.dart'; 

class ScatterGraph extends StatefulWidget {
  final List<List<dynamic>> spots;
  final List<List<double>> coordinates;
  final LatLng centeral;

  const ScatterGraph(
      {super.key,
      required this.spots,
      required this.coordinates,
      required this.centeral});

  @override
  State<ScatterGraph> createState() => _ScatterGraphState();
}

class _ScatterGraphState extends State<ScatterGraph> {
  GoogleMapController? _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    Future<List<Marker>> markersFuture = Future.wait(widget.spots.map((spot) {

      int index = widget.spots.indexOf(spot);
      double ratio = index / (widget.spots.length - 1);
      Color colorMarker = Color.lerp(const Color.fromARGB(255, 247, 1, 1), const Color.fromARGB(255, 255, 153, 0), ratio)!;
      Future c = customMarker(index, colorMarker, Colors.white,  28);

      return c.then((icon) => Marker(
          markerId: MarkerId(spot.toString()),
          position: LatLng(spot[0], spot[1]),
          anchor: Offset(0.5, 0.5),
          icon: icon,
        ));
        
    }).toList());

    final List<LatLng> points =
        widget.coordinates.map((e) => LatLng(e[0], e[1])).toList();
    if (points.isNotEmpty) {
      points.add(points.first);
    }

    if (_controller != null) {
      _controller!.animateCamera(
        CameraUpdate.newLatLng(widget.centeral),
      );
    }

    final List<LatLng> polygonPoints =
      widget.spots.map((spot) => LatLng(spot[0], spot[1])).toList();



    return FutureBuilder<List<Marker>>(
      future: markersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No markers available'));
        } else {
          return SizedBox(
            height: 190,
            width: 340,
            child: GoogleMap(
              mapType: MapType.satellite,
              initialCameraPosition: CameraPosition(
                target: widget.centeral,
                zoom: 17,
              ),
              markers: Set<Marker>.of(snapshot.data!),
              polylines: {
                Polyline(
                  polylineId: PolylineId('area'),
                  points: points,
                  color: const Color.fromARGB(255, 18, 133, 226),
                  width: 2,
                ),
                  Polyline(
                  polylineId: PolylineId('area'),
                  points: polygonPoints,
                  color: Colors.red,
                  width: 2,
                ),
                
              },
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
            ),
          );
        }
      },
    );
  }
}
