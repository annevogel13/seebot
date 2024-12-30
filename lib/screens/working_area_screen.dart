import 'package:flutter/material.dart';
// components 
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';
// getting the location 
import 'package:geolocator/geolocator.dart';
// displaying the map (+ package)
import 'package:seebot/components/google_maps.dart'; 
import 'package:google_maps_flutter/google_maps_flutter.dart';
// firestore
import 'package:seebot/services/firestore.dart';


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
  final TextEditingController _descriptionController = TextEditingController(); 
  List<LatLng> coordinates = [];

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

  void saveArea() async {
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final status = 0 ; // active


    ScaffoldMessenger.of(context).clearSnackBars();
    if (title != '' && coordinates.isNotEmpty) {
          
      final markers = coordinates.map((e) => [e.latitude, e.longitude]);
      // save to firestore
      await firestoreDB.addArea(title, description, status, markers);
      // Implement your save logic here
      if (mounted) {
        final nbPoints = coordinates.length;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Area saved: $title with $nbPoints points'),
            duration: Duration(seconds: 2),
          ),
        );

      _titleController.clear();
      _descriptionController.clear();
      coordinates.clear();
      Navigator.pushNamed(context, '/dashboard');
      Navigator.pushNamed(context, '/showArea');

      }


    } else {
      var message = ''; 
      if(title == '') message = "Please enter a title";
      if(coordinates.isEmpty) message = "Please give an area";

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
      appBar: const UniversalAppBar(title: 'Working on area'),
      body: UniversalBackground(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
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
                    onCoordinatesChanged: (coordinates){
                      setState(() {
                        this.coordinates = coordinates;
                      });
                    },
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (_isKeyboardVisible && _titleController.text == '' ) ? null : saveArea,
                child: (_isKeyboardVisible)? const Text('Choose coordinates') : const Text('Save Area')  ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
