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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LineChartSample2(), 
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
        ),
      ),
    );
  }
}
