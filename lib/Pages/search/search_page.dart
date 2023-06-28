import 'dart:convert';

import 'package:dartproject/Components/pokemon_search_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:states_rebuilder/states_rebuilder.dart';

class PokemonState {
  final String status;
  final Map<String, dynamic> resultSingle;

  PokemonState({
    this.status = 'none',
    this.resultSingle = const {},
  });
}

class PokemonStateService {
  final pokemonNotifier = RM.inject(() => PokemonState());

  Future<void> searchPokemon(var pkm) async {
    var pokeUri = Uri(
      scheme: 'https',
      host: 'pokeapi.co',
      path: 'api/v2/pokemon/$pkm',
    );
    if (pkm != '') {
      try {
        pokemonNotifier.state = PokemonState(status: "loading");
        var jsonString = await http.read(pokeUri);
        var pokeJson = jsonDecode(jsonString);

        pokemonNotifier.state =
            PokemonState(status: 'ready', resultSingle: pokeJson);
      } catch (e) {
        pokemonNotifier.state = PokemonState(status: 'notFound');
      }
    } else {
      pokemonNotifier.state = PokemonState(status: "notFound");
    }
  }
}

final pokemonRep = RM.inject(() => PokemonStateService());

class Search extends ReactiveStatelessWidget {
  Search({super.key});
  final TextEditingController textEditingController = TextEditingController();
  final pokemonObject = RM.inject(() => PokemonState());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TextFormField(
                    controller: textEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () async {
                            String searchQuery =
                                textEditingController.text.toLowerCase();
                            await pokemonRep.state.searchPokemon(searchQuery);
                            pokemonObject.state =
                                pokemonRep.state.pokemonNotifier.state;
                          },
                          icon: const Icon(Icons.search)),
                      hintText: "Digite o nome do Pokémon...",
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                if (pokemonObject.state.status == 'none')
                  const Center(
                    heightFactor: 15,
                    child: Text("Procure por um pokemon"),
                  )
                else if (pokemonObject.state.status == 'loading')
                  const Center(
                    heightFactor: 15,
                    child: CircularProgressIndicator(),
                  )
                else if (pokemonObject.state.status == 'ready')
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(top: 50),
                        child: PokemonSearchCard(
                            pokemon: pokemonObject.state.resultSingle)),
                  )
                else if (pokemonObject.state.status == 'notFound')
                  const Center(
                    heightFactor: 15,
                    child: Text("Pokemon não encontrado"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
