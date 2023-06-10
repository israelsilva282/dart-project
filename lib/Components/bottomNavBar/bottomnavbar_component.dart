import 'package:flutter/material.dart';

class MyBottomNavbar extends StatelessWidget {
  const MyBottomNavbar({super.key});

  void _navigate(index, context) {
    if (index == 0) Navigator.pushNamed(context, '/');
    if (index == 1) Navigator.pushNamed(context, '/search');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (index) {
          _navigate(index, context);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "search")
        ]);
  }
}
