import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';
import 'package:seebot/components/dashboard_tile.dart';

import 'package:seebot/components/graph_slider.dart';
import 'package:seebot/services/firestore.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  late Future<List<List<dynamic>>> data;

  @override
  void initState() {
    super.initState();
    data = firestoreDB.getGraphData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(
        title: 'Dashboard',
      ),
      body: UniversalBackground(
        child: Stack(children: [
          Column(
            children: [
              SizedBox(height: 20),
              Row(children: [
                DashboardTile(
                  color: Theme.of(context).colorScheme.secondary,
                  child: FutureBuilder<List<List<dynamic>>>(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('No data available');
                      } else {
                        return GraphSlider(data: snapshot.data!);
                      }
                    },
                  ),
                ),
              ]),
              Row(children: [
                DashboardTile(
                    color: Theme.of(context).colorScheme.error,
                    child: Text('Box 3')),
                DashboardTile(
                    color: Theme.of(context).colorScheme.tertiary,
                    child: Text('Box 4')),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/steering');
                    },
                    child: Text('Steering'),
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
