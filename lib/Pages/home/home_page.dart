import 'dart:convert';

import 'package:dartproject/Components/bottomNavBar/bottomnavbar_component.dart';
import 'package:dartproject/Pages/pokemon/pokemon_page.dart';
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

      offset += limit; // Aumenta o deslocamento para carregar mais itens
      tableStateNotifier.value +=
          pokemons; // Adiciona os novos itens à lista existente
    } else {
      print(
          'Falha ao carregar os pokémons. Código de status: ${response.statusCode}');
    }
  }
}

final dataService = DataService();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        dataService.loadPokemons().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PokeHome")),
      body: ValueListenableBuilder<List<dynamic>>(
        valueListenable: dataService.tableStateNotifier,
        builder: (context, pokemons, child) {
          return ListView.builder(
            controller: _scrollController, // Adiciona o ScrollController
            padding: const EdgeInsets.all(16),
            itemCount: pokemons.length + 1,
            itemBuilder: (context, index) {
              if (index == pokemons.length) {
                return _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(); // Não exibe nada quando não estiver carregando
              }

              var pokemon = pokemons[index];

              var pokemonImg = pokemon['sprites']['front_default'];

              return Center(
                child: Card(
                  shape: const StadiumBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pokemon(pokemon: pokemon),
                            ),
                          );
                        },
                        title: Text(pokemon['name']),
                        subtitle: Text(pokemon['id'].toString()),
                        leading: Image(
                          width: 100,
                          height: 600,
                          image: NetworkImage(pokemonImg),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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
