import 'package:flutter/material.dart';
import 'package:seebot/graphs/scatter_graph.dart';

class GraphSlider extends StatefulWidget {
  final List<List<dynamic>> data;

  const GraphSlider({super.key, required this.data});

  @override
  State<GraphSlider> createState() => _GraphSliderState();
}

class _GraphSliderState extends State<GraphSlider> {
  int index = 0;

  void _onNext() {
    setState(() {
      if (index < widget.data.length - 1) {
        index++;
      } else if (index + 1 == widget.data.length) {
        index = 0;
      }
    });
  }

  void _onPrevious() {
    setState(() {
      if (index > 0) {
        index--;
      } else if (index == 0) {
        index = widget.data.length - 1;
      }
    });
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
              'Graph for session: ${index + 1}',
              style: TextStyle(fontSize: 12),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: _onNext,
            ),
          ],
        ),
        ScatterGraph(spots: widget.data[index][1]),
      ],
    );
  }
}
