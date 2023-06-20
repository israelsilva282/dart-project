import 'package:flutter/material.dart';
import 'package:states_rebuilder/scr/state_management/extensions/type_extensions.dart';
import 'package:states_rebuilder/scr/state_management/rm.dart';

class Search extends ReactiveStatelessWidget {
  Search({super.key});
  final text = "inicial".inj();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                onChanged: (value) {
                  text.state = value;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText: "Digite o nome do Pokémon...",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            Text(text.state)
          ],
        ));
  }
}
