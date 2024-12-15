
import 'package:flutter/material.dart';
import 'package:seebot/screens/login_screen.dart';
import 'package:seebot/screens/dashboard_screen.dart';
import 'package:seebot/screens/showing_areas_screen.dart';
import 'package:seebot/screens/working_area_screen.dart';
import 'package:seebot/screens/support_screen.dart';


class SeebotApp extends StatefulWidget {

  const SeebotApp({super.key});

  @override
  State<SeebotApp> createState() {
    return _SeebotAppState();
  } 

}

class _SeebotAppState extends State<SeebotApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seebot',
      home: const LoginScreen(),
      routes: <String, WidgetBuilder>{
        '/dashboard': (BuildContext context) => const Dashboard(),
        '/showArea': (BuildContext context) => const ShowArea(),
        '/createArea': (BuildContext context) => const WorkingOnArea(),
        '/support': (BuildContext context) => const SupportScreen(),
      },
    );
  }
}