import 'package:flutter/material.dart';
import 'package:seebot/components/universal_background.dart';

class UniversalAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const UniversalAppBar({required this.title, super.key});

  @override
  State<UniversalAppBar> createState() {
    return _UniversalAppBarState();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _UniversalAppBarState extends State<UniversalAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(30),
            gradient: surfaceGradient, // Use the defined gradient
          ),
          child: IconButton(
            icon: const Icon(Icons.support_agent_outlined, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/support');
            },
          ),
        ),
      ],
    );
  }
}
