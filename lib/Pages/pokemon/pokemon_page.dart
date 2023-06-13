import 'package:dartproject/Components/appBar/appbar_component.dart';
import 'package:flutter/material.dart';

class Pokemon extends StatelessWidget {
  final dynamic pokemon;
  const Pokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: pokemon['name'].toUpperCase()),
        body: Center(
            child: Column(
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Image(
                  fit: BoxFit.contain,
                  image: NetworkImage(pokemon['sprites']['other']
                      ['official-artwork']['front_default']),
                  width: double.infinity,
                  height: 250,
                )),
            Text(pokemon['id'].toString())
          ],
        )));
  }
}
