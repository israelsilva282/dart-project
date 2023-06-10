import 'package:dartproject/Components/appBar/appbar_component.dart';
import 'package:flutter/material.dart';

class Pokemon extends StatelessWidget {
  const Pokemon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: "Pokemon"),
    );
  }
}
