
import 'package:flutter/material.dart';

class UniversalBackground extends StatelessWidget{

  const UniversalBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    
    return DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
          
          ),
          child : child
          );
  }
}