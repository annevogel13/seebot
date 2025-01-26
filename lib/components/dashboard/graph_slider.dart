import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seebot/graphs/scatter_map.dart';
import 'package:seebot/services/firestore.dart';
import 'package:seebot/models/areas.dart';

class GraphSlider extends StatefulWidget {
  final List<List<dynamic>> data;

  const GraphSlider({super.key, required this.data});

  @override
  State<GraphSlider> createState() => _GraphSliderState();
}

class _GraphSliderState extends State<GraphSlider> {
  int index = 0;
  List<List<double>> coordinates = [];
  LatLng center = LatLng(0, 0);
  List<List<double>> points = [];
  Area? area;

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      points = List<List<double>>.from(
          widget.data[index][1].map((item) => List<double>.from(item)));
      _fetchAreaData(widget.data[index][0]);
    }
  }

  void _onNext() {
    setState(() {
      if (index < widget.data.length - 1) {
        index++;
      } else if (index + 1 == widget.data.length) {
        index = 0;
      }
      points = List<List<double>>.from(
          widget.data[index][1].map((item) => List<double>.from(item)));

      _fetchAreaData(widget.data[index][0]);
    });
  }

  void _onPrevious() {
    setState(() {
      if (index > 0) {
        index--;
      } else if (index == 0) {
        index = widget.data.length - 1;
      }
      points = List<List<double>>.from(
          widget.data[index][1].map((item) => List<double>.from(item)));

      _fetchAreaData(widget.data[index][0]);
    });
  }

  void _fetchAreaData(String title) async {
    area = await firestoreDB.getAreaByTitle(title);

    if (area != null) {
      setState(() {
        coordinates = area!.coordinates;
        center = area!.centerCoordinates;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _onPrevious,
            ),
            Text(
              'Graph for session: ${widget.data[index][0]}',
              style: TextStyle(fontSize: 12),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: _onNext,
            ),
          ],
        ),
        coordinates.isEmpty && points.isEmpty
            ? CircularProgressIndicator()
            : ScatterGraph(
                spots: points, coordinates: coordinates, centeral: center),
      ],
    );
  }
}
