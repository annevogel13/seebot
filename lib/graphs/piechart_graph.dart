import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:seebot/services/firestore.dart';

Map<CategorySeebot, Color> categoryColors = {
  CategorySeebot.driving: Color(0xFF2577a2),
  CategorySeebot.mowing: Color(0xFF57cc99),
  CategorySeebot.calculatingDirection:  Color(0xFF38a5a5),
  CategorySeebot.awaitingInstructions: Color(0xFF1b5e7a),
};

class PieChartGraph extends StatelessWidget {
  final Map<CategorySeebot, int> data;

  const PieChartGraph({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: PieChart(
            PieChartData(
              sections: data.entries.map((entry) {
                return PieChartSectionData(
                  color: categoryColors[entry.key],
                  value: entry.value.toDouble(),
                  radius: 50,
                  showTitle: false,
                  title: '',
                );
              }).toList(),
              sectionsSpace: 5,
              centerSpaceRadius: 5,
            ),
          ),
        ),
        Flexible(
          child: Wrap(
            spacing: 5,
            runSpacing: 2,
            children: categoryColors.entries.map((entry) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 16,
                    height: 8,
                    color: entry.value,
                  ),
                  SizedBox(width: 4),
                  Text(entry.key.toString().split('.').last[0].toUpperCase() + entry.key.toString().split('.').last.substring(1)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
