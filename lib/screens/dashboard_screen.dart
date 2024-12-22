import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';
import 'package:seebot/components/dashboard_tile.dart';

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
      appBar: const UniversalAppBar(title: 'Dashboard', ),
      body: UniversalBackground(
        child: Stack(children: [
          Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  DashboardTile(color: Theme.of(context).colorScheme.primary, child: Text('Box 1')),
                  DashboardTile(color: Theme.of(context).colorScheme.secondary, child: Text('Box 2')),
                ],
              ),
              Row(children: [
                DashboardTile(color: Theme.of(context).colorScheme.error, child: Text('Box 3')),
                DashboardTile(color: Theme.of(context).colorScheme.tertiary, child: Text('Box 4')),
              ]),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
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
            ),
          )
        ]),
      ),
    );
  }
}
