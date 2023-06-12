import 'dart:convert';

import 'package:dartproject/Components/bottomNavBar/bottomnavbar_component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataService {
  final ValueNotifier<List<dynamic>> tableStateNotifier = ValueNotifier([]);
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

      tableStateNotifier.value = pokemons;
    } else {
      print(
          'Falha ao carregar os pokémons. Código de status: ${response.statusCode}');
    }
  }
}

final dataService = DataService();

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PokeHome")),
      body: ValueListenableBuilder<List<dynamic>>(
        valueListenable: dataService.tableStateNotifier,
        builder: (context, pokemons, child) {
          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              var pokemon = pokemons[index];
              return ListTile(
                title: Text(pokemon['name']),
                subtitle: Text('ID: ${pokemon['id']}'),
                leading: Image.network(pokemon['sprites']['front_default']),
              );
            },
          );
        },
      ),
      bottomNavigationBar: MyBottomNavbar(),
    );
  }
}
