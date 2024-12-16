import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';

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

  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(title: 'Working on area'),
      body: UniversalBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300, // Set the width to match the container below
                padding: const EdgeInsets.fromLTRB(0,0,0,20),
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Area Title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: const GoogleMap(
                  initialCameraPosition: initialCameraPosition,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
