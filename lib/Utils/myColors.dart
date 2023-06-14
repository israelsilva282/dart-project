import 'package:flutter/material.dart';

class Types {
  static const fire = Colors.orangeAccent;
  static const water = Colors.blueAccent;
  static const grass = Colors.greenAccent;
  static const electric = Colors.yellow;
  static final fairy = Colors.pinkAccent.shade100;
  static final fighting = Colors.deepOrange.shade700;
  static final dark = Colors.blueGrey.shade800;
  static const bug = Colors.lime;
  static final ghost = Colors.deepPurple.shade900;
  static const poison = Colors.purple;
  static final flying = Colors.indigo.shade300;
  static final normal = Colors.grey.shade600;
  static const steel = Color.fromARGB(255, 130, 175, 189);
  static final ice = Colors.blue.shade200;
  static final dragon = Colors.red.shade700;
  static const psychic = Colors.pinkAccent;
  static const ground = Color.fromARGB(218, 236, 180, 12);
  static final rock = Colors.brown.shade800;

  Color pokemonColor(pkmData) {
    switch (pkmData) {
      case 'fire':
        return fire;
      case 'water':
        return water;
      case 'grass':
        return grass;
      case 'electric':
        return electric;
      case 'fairy':
        return fairy;
      case 'fighting':
        return fighting;
      case 'dark':
        return dark;
      case 'bug':
        return bug;
      case 'ghost':
        return ghost;
      case 'poison':
        return poison;
      case 'flying':
        return flying;
      case 'normal':
        return normal;
      case 'steel':
        return steel;
      case 'ice':
        return ice;
      case 'dragon':
        return dragon;
      case 'psychic':
        return psychic;
      case 'ground':
        return ground;
      case 'rock':
        return rock;
      default:
        return Colors.black;
    }
  }
}
