import 'dart:convert';

import 'package:dartproject/Components/bottomNavBar/bottomnavbar_component.dart';
import 'package:dartproject/Components/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:states_rebuilder/states_rebuilder.dart';

class PokemonState {
  final String status;
  final dynamic resultList;

  PokemonState({
    this.status = 'none',
    this.resultList = const [],
  });
}

class DataService {
  final pokemonNotifier = RM.inject(() => PokemonState());
  //final limit = RM.inject(() => 20);
  int limit = 20;

  DataService() {
    loadPokemons();
  }

  Future<void> loadPokemons() async {
    var pokeUri = Uri(
      scheme: 'https',
      host: 'pokeapi.co',
      path: 'api/v2/pokemon/',
      queryParameters: {
        'limit': limit.toString(),
        'offset': "0",
      },
    );

    try {
      var jsonString = await http.read(pokeUri);
      var pokeJson = jsonDecode(jsonString);

      var pokemons = <dynamic>[];

      for (var pokemon in pokeJson['results']) {
        var pokemonUri = Uri.parse(pokemon['url']);
        var pokemonResponse = await http.get(pokemonUri);
        if (pokemonResponse.statusCode == 200) {
          var pokemonJson = jsonDecode(pokemonResponse.body);
          pokemons.add(pokemonJson);
        }
      }

      //limit.state += limit.state;
      limit += 20;

      pokemonNotifier.state =
          PokemonState(status: 'ready', resultList: pokemons);
    } catch (e) {
      pokemonNotifier.state = PokemonState(status: 'notFound');
    }
  }
}

final pokemonService = RM.inject(() => DataService());

class Home extends ReactiveStatelessWidget {
  Home({
    super.key,
  });

  final scroll = RM.injectScrolling(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
      endScrollDelay: 300,
      onScrolling: (scroll) {
        if (scroll.hasReachedMaxExtent) {
          pokemonService.state.loadPokemons();
        }
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pokemon",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        controller: scroll.controller,
        itemCount:
            pokemonService.state.pokemonNotifier.state.resultList.length + 1,
        itemBuilder: (context, index) {
          if (pokemonService.state.pokemonNotifier.state.status == "none") {
            return Container(
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              width: 200,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (index ==
              pokemonService.state.pokemonNotifier.state.resultList.length) {
            return Container(
              width: 50,
              margin: const EdgeInsets.all(10),
              child: const Center(
                child: LinearProgressIndicator(),
              ),
            );
          }

          var pokemon =
              pokemonService.state.pokemonNotifier.state.resultList[index];

          return Center(
            child: Container(
                margin: const EdgeInsets.all(10),
                width: 200,
                child: PokemonCard(pokemon: pokemon)),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const MyBottomNavbar(),
    );
  }
}
