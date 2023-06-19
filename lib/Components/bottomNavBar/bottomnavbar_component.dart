import 'package:flutter/material.dart';

class MyBottomNavbar extends StatelessWidget {
  const MyBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/search');
      },
      child: const Icon(Icons.search),
    );
  }
}
