import 'package:dartproject/Pages/pokemon/pokemon_page.dart';
import 'package:dartproject/Utils/first_letter_up.dart';
import 'package:dartproject/Utils/myColors.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  final dynamic pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Pokemon(pokemon: pokemon),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Types()
                  .pokemonColor(pokemon['types'][0]['type']['name'])
                  .withOpacity(0.8)),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FirstLetterUp().toFirstUpperCase(pokemon['name']),
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(pokemon['id'].toString())
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: pokemon['types']
                                  .map<Widget>((e) => Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white.withOpacity(0.6)),
                                      child: Text(FirstLetterUp()
                                          .toFirstUpperCase(
                                              e['type']['name']))))
                                  .toList())
                        ],
                      ),
                      Flexible(
                          child: Image(
                        image: NetworkImage(pokemon['sprites']['other']
                            ['official-artwork']['front_default']),
                        width: 100,
                      ))
                    ],
                  )
                ],
              )),
        ));
  }
}
