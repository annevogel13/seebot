import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Area {
  final String id ; 
  final String title;
  final String description;
  late IconData icon;

  final int status;
  List<List<double>> coordinates = [];

  Area(
      {
        required this.id, 
        required this.title,
      this.description = '',
      required this.status,
      IconData? iconGiven,
      this.coordinates = const [
        [0.0, 0.0]
      ]}) {
    if (iconGiven == null) {
      // active
      if (status == 0) {
        icon = Icons.location_on_outlined;
        // used
      } else if (status == 1) {
        icon = Icons.location_off;
        // inactive
      } else if (status == 2) {
        icon = Icons.location_off;
      }
    } else {
      icon = iconGiven;
    }
  }

  List<List<double>> get getCoordinates {
    return coordinates;
  }

  LatLng get centerCoordinates {
    double totalLat = 0.0;
    double totalLng = 0.0;

    for (var coordinate in coordinates) {
      totalLat += coordinate[0];
      totalLng += coordinate[1];
    }

    double centerLat = totalLat / coordinates.length;
    double centerLng = totalLng / coordinates.length;

    return LatLng(centerLat, centerLng);
  }

  double get zoomLevel {
    if (coordinates.isEmpty) {
      return 0;
    }

    return 18; 
  }

  ListTile getListView(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      leading: Icon(icon),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(
                  'This is a dialog that shows more information about the area.'),
              actions: <Widget>[
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
  }
}
