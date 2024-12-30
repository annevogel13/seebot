import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScatterGraph extends StatelessWidget {
  final List<dynamic> spots;

  const ScatterGraph({super.key, required this.spots});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: 340,
      child: Center(
        child: ScatterChart(
          ScatterChartData(
            scatterSpots:
                spots.map((spot){ 
                  return ScatterSpot(
                    spot[0], 
                    spot[1],
                    dotPainter: FlDotCirclePainter(
                      radius: 4,
                      color:  Theme.of(context).colorScheme.tertiary,
                    ),); 
                  }).toList(),
            minX: spots.map((spot) => spot[0]).reduce((a, b) => a < b ? a : b),
            maxX: spots.map((spot) => spot[0]).reduce((a, b) => a > b ? a : b),
            minY: spots.map((spot) => spot[1]).reduce((a, b) => a < b ? a : b),
            maxY: spots.map((spot) => spot[1]).reduce((a, b) => a > b ? a : b),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                axisNameWidget: Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Text('Latitude'),
                ),
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value == meta.min || value == meta.max) {
                      return Container(); // Return an empty container for min and max values
                    }
                    return Text(
                      value.toStringAsFixed(3),
                      style: TextStyle(
                          fontSize: 8), // Set the font size to a smaller value
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                axisNameWidget: Text('Longitude'),
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value == meta.min || value == meta.max) {
                      return Container(); // Return an empty container for min and max values
                    }
                    return Text(
                      value.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 8), // Set the font size to a smaller value
                    );
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
