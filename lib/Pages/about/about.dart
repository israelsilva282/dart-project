import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre")),
      body: Center(
          child: Container(
        margin: const EdgeInsets.all(10),
        child: const Text(
            "Este é um aplicativo de Pokedéx, utilizando a API PokéAPI, como parte de um projeto realizado na matéria de Programação Orientada a Objetos II, no curso de Sistemas de Informação.\n O aplicativo foi desenvolvido por:\n\n Israel Costa e Silva (israelsilva282)\n\n Isadora Luana (isazvdd)"),
      )),
    );
  }
}
