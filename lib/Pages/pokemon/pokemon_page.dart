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
            FirstLetterUp().toFirstUpperCase(
                description.toString().replaceAll("(", "").replaceAll(")", "")),
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
          title: Text(
              "#${pokemon['id']} - ${FirstLetterUp().toFirstUpperCase(pokemon['name'])}"),
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
                        height: MediaQuery.of(context).size.height * 0.39,
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var type in pokemon['types'])
                                    Container(
                                      width: 100,
                                      height: 40,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Types()
                                            .pokemonColor(
                                                type['type']['name'].toString())
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          FirstLetterUp().toFirstUpperCase(
                                              type['type']['name']),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              Table(
                                children: [
                                  _newRow(
                                      "Habilidade",
                                      pokemon['abilities'].map((ability) =>
                                          FirstLetterUp().toFirstUpperCase(
                                              ability['ability']['name']))),
                                  _newRow(
                                      'hp', pokemon['stats'][0]['base_stat']),
                                  _newRow('ataque',
                                      pokemon['stats'][1]['base_stat']),
                                  _newRow('defesa',
                                      pokemon['stats'][2]['base_stat']),
                                  _newRow('ataque especial',
                                      pokemon['stats'][3]['base_stat']),
                                  _newRow('defesa especial',
                                      pokemon['stats'][4]['base_stat']),
                                  _newRow('velocidade',
                                      pokemon['stats'][5]['base_stat']),
                                ],
                              ),
                            ],
                          ))
                    ],
                  )),
            )
          ],
        ));
  }
}
