import 'package:flutter/material.dart';

class Area {
  final String title;
  final String description;
  final IconData icon;

  final double latitude;
  final double longitude;
  final List<double> coordinates;

  Area(
      {required this.title,
      required this.description,
      this.icon = Icons.location_on,
      required this.latitude,
      required this.longitude,
      this.coordinates = const []});

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
                  'Latitude: $latitude\nLongitude: $longitude\nCoordinates: $coordinates'),
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
