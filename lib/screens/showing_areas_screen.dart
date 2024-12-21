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
        description: 'This is the first area',
        status: 0,
        coordinates: [37.42796133580664, -122.085749655962],
      ),
      Area(
        title: 'Area 2',
        description: 'This is the second area',
        status: 1,
        coordinates: [37.42796133580664, -122.085749655962],
      ),
      Area(
        title: 'Area 3',
        description: 'This is the third area',
        status: 2,
        coordinates: [37.42796133580664, -122.085749655962],
      ),
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
