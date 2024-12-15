import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';

class ShowArea extends StatelessWidget {
  const ShowArea({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: UniversalAppBar(title: 'Showing Areas'),
      body: UniversalBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Showing Areas'),
            ],
          ),
        ),
      ),
    );
  }
}
