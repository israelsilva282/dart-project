import 'dart:convert';
import 'package:dartproject/Components/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:states_rebuilder/scr/state_management/rm.dart';

class PokemonModel {
  final ValueNotifier tableStateNotifier =
      ValueNotifier({'status': "none", 'result': null});
  Future<void> searchPokemon(var pkm) async {
    var pokeUri = Uri(
      scheme: 'https',
      host: 'pokeapi.co',
      path: 'api/v2/pokemon/$pkm',
    );

    try {
      tableStateNotifier.value = {'status': "loading", 'result': null};
      var jsonString = await http.read(pokeUri);
      var pokeJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'status': pokeJson != [] ? "ready" : "notFound",
        'result': pokeJson
      };
    } catch (e) {
      tableStateNotifier.value = {'status': "error", 'result': null};
    }
  }
}

PokemonModel pkmModel = PokemonModel();

class Search extends ReactiveStatelessWidget {
  Search({super.key});

  final TextEditingController textEditingController = TextEditingController();

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
              controller: textEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                icon: IconButton(
                    onPressed: () async {
                      String searchQuery =
                          textEditingController.text.toLowerCase();
                      await pkmModel.searchPokemon(searchQuery);
                      final dynamic jsonObject =
                          pkmModel.tableStateNotifier.value;
                      print(jsonObject['result']['name']);
                    },
                    icon: const Icon(Icons.search)),
                hintText: "Digite o nome do Pokémon...",
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          if (pkmModel.tableStateNotifier.value['status'] == "ready")
            PokemonCard(pokemon: pkmModel.tableStateNotifier.value['result'])
          else
            const Text("Procure por um pokemon")
        ],
      ),
    );
  }
}
