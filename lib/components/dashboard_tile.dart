import 'package:flutter/material.dart';

class dashboardTile extends StatelessWidget {
  const dashboardTile({super.key, required this.child, required this.color});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 280,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
          child: Center(child: child),
        ),
      ),
    );
  }
}
