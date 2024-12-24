import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class SteeringScreen extends StatefulWidget {
  const SteeringScreen({super.key, required this.startingPosition});

  final LatLng startingPosition;
  @override
  State<SteeringScreen> createState() => _SteeringScreenState();
}

class _SteeringScreenState extends State<SteeringScreen> {
  StreamSubscription? _gyroscopeSubscription;
  Timer? _movementTimer;
  String _direction = "Waiting for input...";
  late LatLng _squarePosition; // Initial position of the square
  GoogleMapController? _mapController; // Controller for Google Map
  bool isMowing = false ; 

  @override
  void initState() {
    super.initState();
    _squarePosition = widget.startingPosition;
    _startGyroscopeListener();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _startGyroscopeListener() {
    _gyroscopeSubscription = gyroscopeEventStream().listen((event) {
      setState(() {
        if (event.x < -0.5 && event.y > 0.5) {
          _setDirection("Forward Right", 0.0001, 0.0001);
        } else if (event.x < -0.5 && event.y < -0.5) {
          _setDirection("Forward Left", 0.0001, -0.0001);
        } else if (event.x > 0.5) {
          _setDirection("Backward", -0.0001, 0);
        } else if (event.y > 0.5) {
          _setDirection("Right", 0, 0.0001);
        } else if (event.y < -0.5) {
          _setDirection("Left", 0, -0.0001);
        }
      });
    });
  }

  void _setDirection(String direction, double latChange, double lngChange) {
    if (_direction != direction) {
      _direction = direction;
      _movementTimer?.cancel();
      if (direction != "Stable") {
        _movementTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
          _moveSquare(latChange, lngChange);
        });
      }
    }
  }

  void _moveSquare(double latChange, double lngChange) {
    setState(() {
      _squarePosition = LatLng(
        _squarePosition.latitude + latChange,
        _squarePosition.longitude + lngChange,
      );
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(_squarePosition),
      );
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    _movementTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gyroscope Steering"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _squarePosition,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: MarkerId("square"),
                position: _squarePosition,
                icon: (isMowing)? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen): BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
              ),
            },
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Direction:",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _direction,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
          ),
          Positioned(
              left: 5,
              bottom: 5,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // change the color of the marker 
                    isMowing = true; 
                  });
                },
                child: Icon(
                  Icons.grass_rounded,
                  size: 30,
                ),
              ))
        ],
      ),
    );
  }
}
