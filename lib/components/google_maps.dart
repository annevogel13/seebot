import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.currentLocation, required this.onCoordinatesChanged});

  final Position currentLocation;
  final Function(List<LatLng>) onCoordinatesChanged;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  CameraPosition? _initialCameraPosition;

  bool _isMapFrozen = false;

  final Set<Marker> _markers = {};
  final List<LatLng> _markerCoordinates = [];
  final Set<Polygon> _polygons = {};

  @override
  void initState() {
    super.initState();

    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    setState(() {
      _initialCameraPosition = CameraPosition(
        target: LatLng(
            widget.currentLocation.latitude, widget.currentLocation.longitude),
        zoom: 20.0,
      );
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapTapped(LatLng position) {
    if (_isMapFrozen) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('marker_id_${_markers.length}'),
            position: position,
            onTap: () {},
          ),
        );
      });

      _markerCoordinates.add(position);
      widget.onCoordinatesChanged(_markerCoordinates);
      _updatePolygon();
    }
  }

  // Update the polygon to form a closed shape
  void _updatePolygon() {
    if (_markerCoordinates.isNotEmpty) {
      _polygons.clear(); // Remove the old polygon
      _polygons.add(
        Polygon(
          polygonId: PolygonId('polygon_1'),
          points: [
            ..._markerCoordinates,
            _markerCoordinates.first
          ], // Close the shape
          fillColor:
              Colors.blue.withValues(alpha: .2), // Fill color with transparency
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition!,
            onMapCreated: (controller) {
              _mapController = controller;
            },
            mapType: MapType.satellite,
            markers: _markers,
            polygons: _polygons,
            onTap: _onMapTapped,
            zoomGesturesEnabled: !_isMapFrozen,
            scrollGesturesEnabled: !_isMapFrozen,
            rotateGesturesEnabled: !_isMapFrozen,
            tiltGesturesEnabled: !_isMapFrozen,
            compassEnabled: false,
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _isMapFrozen = !_isMapFrozen;
                  });
                },
                icon: Icon(_isMapFrozen ? Icons.lock : Icons.lock_open),
                tooltip: _isMapFrozen ? 'Unlock map' : 'Lock map',
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _polygons.clear();
                    _markers.clear();
                    _markerCoordinates.clear();
                  });
                },
                icon: Icon(Icons.delete),
                tooltip: 'Clear map',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
