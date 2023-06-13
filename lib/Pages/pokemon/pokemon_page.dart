import 'package:dartproject/Components/appBar/appbar_component.dart';
import 'package:flutter/material.dart';

class Pokemon extends StatelessWidget {
  dynamic _newRow(title, description) {
    return TableRow(children: [
      Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          child: Text(
            title.toString().toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          )),
      Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            description.toString().toUpperCase(),
            style: const TextStyle(fontSize: 10),
          )),
    ]);
  }

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
            Table(
              children: [
                _newRow('id', pokemon['id']),
                _newRow(
                    'Habilidade',
                    pokemon['abilities'][0]['ability']['name'] +
                        " " +
                        pokemon['abilities'][1]['ability']['name']),
                _newRow(
                    'Tipo',
                    pokemon['types'][0]['type']['name'] +
                        " " +
                        pokemon['types'][1]['type']['name']),
                _newRow('hp', pokemon['stats'][0]['base_stat']),
                _newRow('ataque', pokemon['stats'][1]['base_stat']),
                _newRow('defesa', pokemon['stats'][2]['base_stat']),
                _newRow('ataque especial', pokemon['stats'][3]['base_stat']),
                _newRow('defesa especial', pokemon['stats'][4]['base_stat']),
                _newRow('velocidade', pokemon['stats'][5]['base_stat']),
              ],
            )
          ],
        )));
  }
}
