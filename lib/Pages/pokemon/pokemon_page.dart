import 'package:dartproject/Components/appBar/appbar_component.dart';
import 'package:flutter/material.dart';

class Pokemon extends StatelessWidget {
  final dynamic pokemon;
  const Pokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Pokemon"),
      body: Text(pokemon['name']),
    );
  }
}
