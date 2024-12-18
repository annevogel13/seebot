import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';
import 'package:geolocator/geolocator.dart';
import 'package:seebot/components/google_maps.dart'; 

class WorkingOnArea extends StatefulWidget {
  const WorkingOnArea({super.key, required this.currentLocation});

  final Position currentLocation;

  @override
  State<WorkingOnArea> createState() {
    return _WorkingOnAreaState();
  }
}

class _WorkingOnAreaState extends State<WorkingOnArea> {
  late CameraPosition initialCameraPosition;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController(); // Controller for description
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _initializeCameraPosition();

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
        target: LatLng(
            widget.currentLocation.latitude, widget.currentLocation.longitude),
        zoom: 12.0, // Adjust zoom level as needed
      );
    });
  }

  void saveArea() {
    final String title = _titleController.text;
    final String description = _descriptionController.text;

    ScaffoldMessenger.of(context).clearSnackBars();
    if (title != '') {
      // Implement your save logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Area saved: $title with $description'),
          duration: Duration(seconds: 2),
        ),
      );

      // adding title / description

      Navigator.pushNamed(context, '/showArea');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a title'),
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
      appBar: const UniversalAppBar(title: 'Working on area'),
      body: UniversalBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300, // Set the width to match the container below
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
                width: 300, // Set the width to match the container below
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
                    currentLocation: widget.currentLocation,
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveArea,
                child: const Text('Save Area'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
