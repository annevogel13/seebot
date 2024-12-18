import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';
import 'package:seebot/models/areas.dart'; // Import the Area model
import 'package:seebot/components/show_figure_on_map.dart'; // Import the PolygoneShowMap component

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
            return ListTile(
              title: Text(areas[index].title),
              subtitle: Text(areas[index].description),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(areas[index].title),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(areas[index].description),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 200,
                            child: PolygoneShowMap(),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
