import 'package:flutter/material.dart';

class PokemonUtils {
  static Color getTypeColor(String type) {
    switch (type) {
      case 'Grass': return Colors.greenAccent;
      case 'Fire': return Colors.redAccent;
      case 'Water': return Colors.blue;
      case 'Poison': return Colors.deepPurpleAccent;
      case 'Electric': return Colors.amber;
      case 'Rock': return Colors.grey;
      case 'Ground': return Colors.brown;
      case 'Psychic': return Colors.indigo;
      case 'Fighting': return Colors.orange;
      case 'Bug': return Colors.lightGreenAccent;
      case 'Ghost': return Colors.deepPurple;
      case 'Normal': return Colors.black26;
      default: return Colors.pink;
    }
  }
}