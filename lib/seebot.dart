
import 'package:flutter/material.dart';
import 'package:seebot/screens/login_screen.dart';
import 'package:seebot/screens/dashboard_screen.dart';
import 'package:seebot/screens/showing_areas_screen.dart';
import 'package:seebot/screens/working_area_screen.dart';
import 'package:seebot/screens/support_screen.dart';

import 'package:geolocator/geolocator.dart';
import 'package:seebot/functions/current_location.dart';

//TODO LIST 
// 1. What happens if a user doesn't gave location permission?

class SeebotApp extends StatefulWidget {

  const SeebotApp({super.key});

  @override
  State<SeebotApp> createState() {
    return _SeebotAppState();
  } 

}

class _SeebotAppState extends State<SeebotApp> {

  late Position currentLocation ; 

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final location = await getCurrentLocation();
    setState(() {
      currentLocation = location;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seebot',
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: Color(0xFF2577a2), // #2577a2
          primaryContainer: Color(0xFF1b5e7a), // Darker shade of primary
          secondary: Color(0xFF38a5a5), // #38a5a5
          secondaryContainer: Color(0xFF2a7d7d), // Darker shade of secondary
          tertiary: Color(0xFFCEB5A7),
          surfaceBright: Color(0xFF57cc99), // #57cc99
          surface: Color(0xFFCEB5A7) ,  //Color(0xFF38a5a5), // #3aaed8
          error: Color(0xFFda291c), // #da291c
          onPrimary: Color(0xFF1b5e7a),
          onSecondary: Colors.white,
          onSurface: Color(0xFF2577a2),
          onError: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      home: const LoginScreen(),
      routes: <String, WidgetBuilder>{
        '/dashboard': (BuildContext context) => const Dashboard(),
        '/showArea': (BuildContext context) => const ShowArea(),
        '/createArea': (BuildContext context) => WorkingOnArea(currentLocation: currentLocation,),
        '/support': (BuildContext context) => const SupportScreen(),
      },
    );
  }
}