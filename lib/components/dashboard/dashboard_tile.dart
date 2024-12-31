import 'package:flutter/material.dart';

class DashboardTile extends StatelessWidget {
  const DashboardTile({super.key, required this.child, required this.color});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:  Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
          height: 280,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
          child: Center(child: child),
        ),
      
    );
  }
}
