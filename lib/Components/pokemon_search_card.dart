import 'package:dartproject/Pages/pokemon/pokemon_page.dart';
import 'package:dartproject/Utils/first_letter_up.dart';
import 'package:dartproject/Utils/myColors.dart';
import 'package:flutter/material.dart';

class PokemonSearchCard extends StatelessWidget {
  final dynamic pokemon;
  const PokemonSearchCard({super.key, required this.pokemon});

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
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              "#${pokemon['id']} - ${FirstLetterUp().toFirstUpperCase(pokemon['name'])}",
              style: const TextStyle(fontSize: 22),
            ),
          ),
          Image(
            image: NetworkImage(pokemon['sprites']['other']['official-artwork']
                ['front_default']),
            height: 200,
          ),
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
                        .pokemonColor(type['type']['name'].toString())
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      FirstLetterUp().toFirstUpperCase(type['type']['name']),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                )
            ],
          )
        ]));
  }
}
