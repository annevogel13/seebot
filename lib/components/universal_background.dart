import 'package:flutter/material.dart';
const LinearGradient surfaceGradient = LinearGradient(
  colors: [Color(0xFF57cc99), Color(0xFF3aaed8)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

 // Import the theme file

class UniversalBackground extends StatelessWidget {
  final Widget child;

  const UniversalBackground({required this.child, super.key}) ;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: surfaceGradient, // Use the defined gradient
      ),
      child: child,
    );
  }
}
