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
                      Icon(areas[index].icon), // Assuming 'icon' is a property in the Area model
                      SizedBox(width: 8),
                      Text(areas[index].title),
                      ],
                    ),
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
                            ]
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
