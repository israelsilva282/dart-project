import 'dart:convert';

import 'package:dartproject/Components/appBar/appbar_component.dart';
import 'package:dartproject/Components/bottomNavBar/bottomnavbar_component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataService {
  final ValueNotifier<List> tableStateNotifier = ValueNotifier([]);
  final ValueNotifier<List<String>> propertyNamesNotifier = ValueNotifier([]);

  DataService() {
    loadPokemons();
  }

  Future<void> loadPokemons({int limit = 10}) async {
    var pokeUri = Uri(
        scheme: 'https',
        host: 'pokeapi.co',
        path: 'api/v2/pokemon/',
        queryParameters: {
          'limit': limit.toString(),
          'offset': '0',
        });

    var jsonString = await http.read(pokeUri);

    var pokeJson = jsonDecode(jsonString);

    var pokemonList = pokeJson['results'];

    var pokemons = <dynamic>[];

    for (var pokemon in pokemonList) {
      var pokemonUri = Uri.parse(pokemon['url']);
      var pokemonJsonString = await http.read(pokemonUri);
      var pokemonJson = jsonDecode(pokemonJsonString);
      pokemons.add(pokemonJson);
    }

    tableStateNotifier.value = pokemons;
  }
}

final dataService = DataService();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: "PokeHome"),
      bottomNavigationBar: MyBottomNavbar(),
    );
  }
}
