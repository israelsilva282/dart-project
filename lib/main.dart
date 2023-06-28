import 'package:dartproject/Pages/about/about.dart';
import 'package:dartproject/Pages/home/home_page.dart';
import 'package:dartproject/Pages/pokemon/pokemon_page.dart';
import 'package:dartproject/Pages/search/search_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PokeDex",
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/search': (context) => Search(),
        '/pokemon': (context) => const Pokemon(pokemon: null),
        '/about': (context) => const About()
      },
    );
  }
}
