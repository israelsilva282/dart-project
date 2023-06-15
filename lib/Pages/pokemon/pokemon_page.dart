import 'package:dartproject/Utils/first_letter_up.dart';
import 'package:dartproject/Utils/myColors.dart';
import 'package:flutter/material.dart';

class Pokemon extends StatelessWidget {
  dynamic _newRow(title, description) {
    return TableRow(children: [
      Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            FirstLetterUp().toFirstUpperCase(title),
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )),
      Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            FirstLetterUp().toFirstUpperCase(description.toString()),
            style: const TextStyle(fontSize: 16),
          )),
    ]);
  }

  final dynamic pokemon;
  const Pokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pokemon['name']),
          elevation: 0,
          backgroundColor:
              Types().pokemonColor(pokemon['types'][0]['type']['name']),
        ),
        body: ListView(
          children: [
            Center(
              child: Container(
                  decoration: BoxDecoration(
                      color: Types()
                          .pokemonColor(pokemon['types'][0]['type']['name']),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Column(
                    children: [
                      Image(
                        fit: BoxFit.contain,
                        image: NetworkImage(pokemon['sprites']['other']
                            ['official-artwork']['front_default']),
                        width: double.infinity,
                        height: 250,
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          child: Table(
                            children: [
                              _newRow('id', pokemon['id']),
                              if (pokemon['abilities'].length > 1)
                                _newRow(
                                    'Habilidade',
                                    FirstLetterUp().toFirstUpperCase(
                                            pokemon['abilities'][0]['ability']
                                                ['name']) +
                                        ", ".toString() +
                                        FirstLetterUp().toFirstUpperCase(
                                            pokemon['abilities'][1]['ability']
                                                ['name'])),
                              if (pokemon['abilities'].length == 1)
                                _newRow(
                                    'Habilidade',
                                    FirstLetterUp().toFirstUpperCase(
                                        pokemon['abilities'][0]['ability']
                                            ['name'])),
                              if (pokemon['types'].length > 1)
                                _newRow(
                                    'Tipo',
                                    FirstLetterUp().toFirstUpperCase(
                                            pokemon['types'][0]['type']
                                                ['name']) +
                                        ", ".toString() +
                                        FirstLetterUp().toFirstUpperCase(
                                            pokemon['types'][1]['type']
                                                ['name'])),
                              if (pokemon['types'].length == 1)
                                _newRow(
                                    'Tipo',
                                    FirstLetterUp().toFirstUpperCase(
                                        pokemon['types'][0]['type']['name'])),
                              _newRow('hp', pokemon['stats'][0]['base_stat']),
                              _newRow(
                                  'ataque', pokemon['stats'][1]['base_stat']),
                              if (pokemon['types'].length > 1)
                                _newRow(
                                    'defesa', pokemon['stats'][2]['base_stat']),
                              _newRow('ataque especial',
                                  pokemon['stats'][3]['base_stat']),
                              _newRow('defesa especial',
                                  pokemon['stats'][4]['base_stat']),
                              _newRow('velocidade',
                                  pokemon['stats'][5]['base_stat']),
                            ],
                          ))
                    ],
                  )),
            )
          ],
        ));
  }
}
