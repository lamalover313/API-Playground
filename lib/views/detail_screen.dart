import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/widgets/pokemon_color_type.dart';


class DetailPage extends StatelessWidget {
  final Map<String, dynamic> pokemon;

  const DetailPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final color = PokemonUtils.getTypeColor(pokemon['type'][0]);

    return Scaffold(
      backgroundColor: color,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Positioned(
                  right: -50,
                  top: -50,
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset('lib/assets/pokeball.png', width: 200),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: pokemon['num'],
                        child: CachedNetworkImage(
                          imageUrl: pokemon['img'],
                          height: 150,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(pokemon['name'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            Text("#${pokemon['num']}", style: const TextStyle(fontSize: 18)),
                            Text("${pokemon['type'].join(', ')}", style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => context.pop(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 36, 33, 33),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Text("Height: ${pokemon['height']}", style: const TextStyle(fontSize: 18)),
                  Text("Weight: ${pokemon['weight']}", style: const TextStyle(fontSize: 18)),
                  Text("Type: ${pokemon['type'].join(', ')}", style: const TextStyle(fontSize: 18)),
                  Text("Weakness: ${pokemon['weaknesses']?.join(', ') ?? 'None'}", style: const TextStyle(fontSize: 18)),
                  if (pokemon['prev_evolution'] != null)
                    Text("Prev. Evolution: ${pokemon['prev_evolution'].map((e) => e['name']).join(', ')}", style: const TextStyle(fontSize: 18)),
                  if (pokemon['next_evolution'] != null)
                    Text("Next Evolution: ${pokemon['next_evolution'].map((e) => e['name']).join(', ')}", style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}