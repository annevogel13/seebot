import 'package:flutter/material.dart';
import 'package:seebot/components/universal/universal_appbar.dart';
import 'package:seebot/models/areas.dart'; // Import the Area model
import 'package:seebot/services/firestore.dart';
import 'package:seebot/components/listingAreas/area_list.dart'; // Import the AreaList component
import 'package:seebot/components/modify_area.dart'; // Import the ModifyArea component

class ShowArea extends StatefulWidget {
  const ShowArea({super.key});

  @override
  State<ShowArea> createState() => _ShowAreaState();
}

class _ShowAreaState extends State<ShowArea> {
  late List<Area> areas;

  Future<List<Area>> getAreas() async {
    // Implement your logic to fetch areas here
    return await firestoreDB.getAreas();
  }

  void removeArea(index) async {
    final deletedArea = areas[index];
    // Implement your logic to delete the area here
    firestoreDB.deleteArea(areas[index].id);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Area deleted'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              firestoreDB.addArea(deletedArea.title, deletedArea.description,
                  deletedArea.status, deletedArea.coordinates);
              setState(() {
                areas.insert(index, deletedArea);
              });
            }),
      ),
    );
  }

  void modifyArea(index) {
    // Implement your logic to modify the area here
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModifyArea(area: areas[index]),
      ),
    );
    
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
            areas = snapshot.data!;
            return AreaList(
              areas: areas,
              removeArea: removeArea,
              modifyArea: modifyArea,
            );
          }
        },
      ),
    );
  }
}
