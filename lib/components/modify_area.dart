import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seebot/components/google_maps.dart';
import 'package:seebot/services/firestore.dart';
import 'package:seebot/models/areas.dart';
import 'dart:convert';
import 'package:seebot/components/universal_background.dart';

class ModifyArea extends StatefulWidget {
  const ModifyArea({super.key, required this.area});

  final Area area;

  @override
  State<ModifyArea> createState() {
    return _ModifyAreaState();
  }
}

class _ModifyAreaState extends State<ModifyArea> {
  late CameraPosition initialCameraPosition;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<LatLng> coordinates = [];

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _initializeCameraPosition();
    _titleController.text = widget.area.title;
    _descriptionController.text = widget.area.description;
    coordinates =
        widget.area.getCoordinates.map((e) => LatLng(e[0], e[1])).toList();

    _titleFocusNode.addListener(_handleFocusChange);
    _descriptionFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isKeyboardVisible =
          _titleFocusNode.hasFocus || _descriptionFocusNode.hasFocus;
    });
  }

  void _initializeCameraPosition() {
    setState(() {
      initialCameraPosition = CameraPosition(
        target: widget.area.centerCoordinates,
        zoom: 12.0,
      );
    });
  }

  void saveArea() async {
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final status = widget.area.status;

    ScaffoldMessenger.of(context).clearSnackBars();
    if (title != '' && coordinates.isNotEmpty) {
      final markers = coordinates.map((e) => [e.latitude, e.longitude]);
      await firestoreDB.updateArea(widget.area.id, {
        'title': title,
        'description': description,
        'status': status,
        'markers': jsonEncode(markers.toList()),
      });

      if (mounted) {
        final nbPoints = coordinates.length;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Area updated: $title with $nbPoints points'),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.pop(context);
      }
    } else {
      var message = '';
      if (title == '') message = "Please enter a title";
      if (coordinates.isEmpty) message = "Please give an area";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modify Area'), automaticallyImplyLeading: false,),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              width: 300,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: TextField(
                controller: _titleController,
                focusNode: _titleFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Area Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              width: 300,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: TextField(
                controller: _descriptionController,
                focusNode: _descriptionFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Area Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            if (!_isKeyboardVisible)
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: MapScreen(
                  coordinates: coordinates,
                  currentLocation: Position(
                    latitude: widget.area.centerCoordinates.latitude,
                    longitude: widget.area.centerCoordinates.longitude,
                    timestamp: DateTime.now(),
                    accuracy: 0,
                    altitude: 0,
                    heading: 0,
                    speed: 0,
                    speedAccuracy: 0,
                    altitudeAccuracy: 0,
                    headingAccuracy: 0,
                  ),
                  onCoordinatesChanged: (newCoordinates) {
                    setState(() {
                      coordinates = newCoordinates;
                    });
                  },
                ),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      surfaceGradient.createShader(bounds),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      textStyle: TextStyle(color: Colors.white),
                    ),
                    onPressed: saveArea,
                    child: const Text(
                      'Save changes to area',
                      style: TextStyle(
                        color: Colors.black, // Ensure the text color is white
                        fontWeight: FontWeight
                            .bold, // Optional: Make the text bold for better readability
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      surfaceGradient.createShader(bounds),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      textStyle: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black, // Ensure the text color is white
                        fontWeight: FontWeight
                            .bold, // Optional: Make the text bold for better readability
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
