import 'package:flutter/material.dart';

class Area {
  final String title;
  final String description;
  late IconData icon;

  final int status;
  final List<double> coordinates;

  Area(
      {required this.title,
      this.description = '',
      required this.status,
      IconData? iconGiven,
      this.coordinates = const []}) {
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
