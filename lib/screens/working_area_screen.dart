import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seebot/components/universal_appbar.dart';

class WorkingOnArea extends StatefulWidget {
  const WorkingOnArea({super.key});

  @override
  State<WorkingOnArea> createState() {
    return _WorkingOnAreaState();
  }
}

class _WorkingOnAreaState extends State<WorkingOnArea> {

  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco as an example
    zoom: 12.0, // Adjust zoom level as needed
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  UniversalAppBar(title: 'Working on area'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Working on area'),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child : GoogleMap(initialCameraPosition: initialCameraPosition)
            )
          
          ],
        ),
      ),
    );
  }
}
