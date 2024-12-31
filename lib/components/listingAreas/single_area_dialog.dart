import 'package:flutter/material.dart';
import 'package:seebot/models/areas.dart';
import 'package:seebot/components/listingAreas/show_figure_on_map.dart'; // Import the PolygoneShowMap component

class AreaDialog extends StatelessWidget {
  const AreaDialog({super.key, required this.area});

  final Area area;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(area.icon),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              area.title,
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
              area.description[0].toUpperCase() + area.description.substring(1),
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'The number of points in the area is : ${area.getCoordinates.length}',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: PolygoneShowMap(
                area: area,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor, // Background color
            side: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1), // Border color and width
          ),
          child: Text('Close', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
