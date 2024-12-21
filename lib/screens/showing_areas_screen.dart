import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';

import 'package:seebot/models/areas.dart'; // Import the Area model
import 'package:seebot/services/firestore.dart';
import 'package:seebot/components/single_area_dialog.dart'; // Import the AreaDialog component

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
                // onDismissed: (direction) => removeExpense(expenses[index]),
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
                          return AreaDialog(area: areas[index]);
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
