import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';

class WorkingOnArea extends StatefulWidget {
  const WorkingOnArea({super.key});

  @override
  State<WorkingOnArea> createState() {
    return _WorkingOnAreaState();
  }
}

class _WorkingOnAreaState extends State<WorkingOnArea> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  UniversalAppBar(title: 'Working on area'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Working on area'),
          ],
        ),
      ),
    );
  }
}
