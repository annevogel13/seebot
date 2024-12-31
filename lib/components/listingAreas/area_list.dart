import 'package:flutter/material.dart';
import 'package:seebot/models/areas.dart';
import 'package:seebot/components/universal/universal_background.dart';
import 'package:seebot/components/listingAreas/single_area_dialog.dart';

class AreaList extends StatelessWidget {
  const AreaList({super.key, required this.areas, required this.removeArea, required this.modifyArea});

  final List<Area> areas;
  final Function removeArea;
  final Function modifyArea;

  @override
  Widget build(BuildContext context) {
    return UniversalBackground(
      child: ListView.builder(
        itemCount: areas.length,
        itemBuilder: (context, index) => Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          key: ValueKey(index),
          onDismissed: (direction) => removeArea(index),
          child: ListTile(
            title: Row(
              children: [
                Icon(areas[index].icon),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    areas[index].title[0].toUpperCase() +
                        areas[index].title.substring(1),
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
            trailing: IconButton(
              onPressed: () => modifyArea(index),
              icon: Icon(Icons.edit),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AreaDialog(area: areas[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
