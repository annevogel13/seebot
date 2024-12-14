
import 'package:flutter/material.dart';
import 'package:seebot/screens/logInScreen.dart';


class SeebotApp extends StatefulWidget {

  const SeebotApp({super.key});

  @override
  _SeebotAppState createState() => _SeebotAppState();
}


class _SeebotAppState extends State<SeebotApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seebot',
      home: const LogInScreen(),
    );
  }
}