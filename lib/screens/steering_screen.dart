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

  @override
  void initState() {
    super.initState();
    _squarePosition = widget.startingPosition;
    _startGyroscopeListener();
  }

  void _startGyroscopeListener() {
    _gyroscopeSubscription = gyroscopeEventStream().listen((event) {
      setState(() {
        if (event.x < -0.5 && event.y > 0.5) {
          _setDirection("Forward Right", 0.0001, 0.0001);
        } else if (event.x < -0.5 && event.y < -0.5) {
          _setDirection("Forward Left", 0.0001, -0.0001);
        } else if (event.x > 0.5 && event.y > 0.5) {
          _setDirection("Backward Right", -0.0001, 0.0001);
        } else if (event.x > 0.5 && event.y < -0.5) {
          _setDirection("Backward Left", -0.0001, -0.0001);
        } else if (event.x < -0.5) {
          _setDirection("Forward", 0.0001, 0);
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
            initialCameraPosition: CameraPosition(
              target: _squarePosition,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: MarkerId("square"),
                position: _squarePosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              ),
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Column(
              children: [
                Text(
                  "Direction:",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  _direction,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
