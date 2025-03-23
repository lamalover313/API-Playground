import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  static const String url = 'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  static Future<List<dynamic>> fetchPokemonData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['pokemon'];
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    return [];
  }
}
