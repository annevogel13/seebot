import 'package:flutter/material.dart';

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
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue),
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
