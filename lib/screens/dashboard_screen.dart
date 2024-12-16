import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';
import 'package:seebot/components/chart_example.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(title: 'Dashboard'),
      body: UniversalBackground(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    color: Colors.blue,
                    child: Center(child: Text('Box 1')),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    color: Colors.red,
                    child: Center(child: Text('Box 2')),
                  ),
                ),
              ],
            ),
            Row(children: [
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.blue,
                  child: Center(child: Text('Box 3')),
                ),
              ),
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.red,
                  child: Center(child: Text('Box 4')),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/showArea');
                  },
                  child: const Text('Go to area'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/createArea');
                  },
                  child: const Text('Create area'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
