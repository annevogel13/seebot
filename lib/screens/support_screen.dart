import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: UniversalAppBar(title: 'Support Screen'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Support Screen'),
          ],
        ),
      ),
    );
  }
}