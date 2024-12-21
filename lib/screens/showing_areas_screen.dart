import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';
import 'package:seebot/models/areas.dart'; // Import the Area model
import 'package:seebot/components/show_figure_on_map.dart'; // Import the PolygoneShowMap component
import 'package:seebot/services/firestore.dart';

class ShowArea extends StatelessWidget {
  const ShowArea({super.key});

  Future<List<Area>> getAreas() async {
    // Implement your logic to fetch areas here
    return await FirestoreService().getAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(title: 'Showing Areas'),
      body: FutureBuilder<List<Area>>(
        future: getAreas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No areas available'));
          } else {
            List<Area> areas = snapshot.data!;
            return UniversalBackground(
              child: ListView.builder(
                itemCount: areas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Icon(areas[index]
                            .icon), // Assuming 'icon' is a property in the Area model
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            areas[index].title,
                            softWrap: true,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      areas[index].description,
                      textAlign: TextAlign.left,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Icon(areas[index].icon),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    areas[index].title,
                                    softWrap: true,
                                    textAlign: TextAlign.left,
                                        style: TextStyle(color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text(
                                    areas[index].description[0].toUpperCase() + areas[index].description.substring(1),
                                    textAlign: TextAlign.left,
                                        style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'The number of points in the area is : ${areas[index].getCoordinates.length}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    height: 200,
                                    child: PolygoneShowMap(
                                      area: areas[index],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor, // Background color
                                  side: BorderSide(color: Theme.of(context).primaryColor, width: 1), // Border color and width
                                ),
                                child: Text('Close', style: TextStyle(color: Colors.white)),
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
            );
          }
        },
      ),
    );
  }
}
