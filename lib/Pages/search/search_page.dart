import 'package:flutter/material.dart';
import 'package:states_rebuilder/scr/state_management/rm.dart';

class Search extends ReactiveStatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Digite o nome do Pokémon...",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            Text("Test")
          ],
        ));
  }
}
