import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';
import 'package:seebot/models/areas.dart'; // Import the Area model

class ShowArea extends StatelessWidget {
  const ShowArea({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a list of Area objects
    final List<Area> areas = [
      Area(
        title: 'Area 1',
        description: 'Description of Area 1',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      Area(
        title: 'Area 2',
        description: 'Description of Area 2',
        latitude: 34.0522,
        longitude: -118.2437,
      ),
      // Add more Area objects as needed
    ];

    return Scaffold(
      appBar: const UniversalAppBar(title: 'Showing Areas'),
      body: UniversalBackground(
        child: ListView.builder(
          itemCount: areas.length,
          itemBuilder: (context, index) {
            return areas[index].getListView(context);
          },
        ),
      ),
    );
  }
}
