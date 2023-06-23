import 'dart:convert';

import 'package:dartproject/Components/bottomNavBar/bottomnavbar_component.dart';
import 'package:dartproject/Components/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataService {
  final ValueNotifier<List<dynamic>> tableStateNotifier = ValueNotifier([]);
  final ValueNotifier<List<String>> propertyNamesNotifier = ValueNotifier([]);

  int limit = 20; // Quantidade inicial de itens a serem carregados
  int offset = 0; // Deslocamento inicial dos itens

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
        'offset': offset.toString(),
      },
    );

    var response = await http.get(pokeUri);

    if (response.statusCode == 200) {
      var pokeJson = jsonDecode(response.body);

      var pokemonList = pokeJson['results'];

      var pokemons = <dynamic>[];

      for (var pokemon in pokemonList) {
        var pokemonUri = Uri.parse(pokemon['url']);
        var pokemonResponse = await http.get(pokemonUri);
        if (pokemonResponse.statusCode == 200) {
          var pokemonJson = jsonDecode(pokemonResponse.body);
          pokemons.add(pokemonJson);
        }
      }

      tableStateNotifier.value = [...tableStateNotifier.value, ...pokemons];
      offset += limit; // Atualiza o deslocamento
    }
  }
}

final dataService = DataService();

class Home extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  Home({
    super.key,
  }) {
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      dataService.loadPokemons();
    }
  }

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
      body: ValueListenableBuilder<List<dynamic>>(
        valueListenable: dataService.tableStateNotifier,
        builder: (context, pokemons, child) {
          if (pokemons.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: (MediaQuery.of(context).size.width ~/ 160).toInt(),
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            controller: _scrollController, // Adicione o controller de scroll
            children: List.generate(pokemons.length + 1, (index) {
              if (index == pokemons.length) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var pokemon = pokemons[index];

              return PokemonCard(pokemon: pokemon);
            }),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: MyBottomNavbar(),
      ),
    );
  }
}
