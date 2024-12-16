import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';
import 'package:seebot/functions/current_location.dart'; // Import the getCurrentLocation function

class WorkingOnArea extends StatefulWidget {
  const WorkingOnArea({super.key});

  @override
  State<WorkingOnArea> createState() {
    return _WorkingOnAreaState();
  }
}

class _WorkingOnAreaState extends State<WorkingOnArea> {
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(37.7749, -122.4194), // Default to San Francisco
    zoom: 12.0, // Adjust zoom level as needed
  );

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController(); // Controller for description
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
      _isKeyboardVisible = _titleFocusNode.hasFocus || _descriptionFocusNode.hasFocus;
    });
  }

  Future<void> _initializeCameraPosition() async {
    try {
      final position = await getCurrentLocation();
      setState(() {
        _isKeyboardVisible = true;
        initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 12.0, // Adjust zoom level as needed
        );

        _isKeyboardVisible = false;
      });
    } catch (e) {
      // Handle the error, e.g., show a snackbar or dialog
      print('Error fetching location: $e');
    }
  }

  void saveArea() {
    final String title = _titleController.text;
    final String description = _descriptionController.text;

    ScaffoldMessenger.of(context).clearSnackBars();
    if (title != '') {
      // Implement your save logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Area saved: $title'),
          duration: Duration(seconds: 2),
        ),
      );

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
                    child: GoogleMap(
                      initialCameraPosition: initialCameraPosition,
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
