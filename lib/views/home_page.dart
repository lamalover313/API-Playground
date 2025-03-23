import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/API/api_provider.dart';
import 'package:myapp/widgets/pokemon_color_type.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<dynamic> pokedex = [].obs;

  @override
  void initState() {
    super.initState();
    loadPokemonData();
  }

  void loadPokemonData() async {
    final data = await PokemonService.fetchPokemonData();
    for (var i = 0; i < data.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        setState(() {
          pokedex.add(data[i]);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Positioned(
              right: -20,
              top: -10,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset('lib/assets/pokeball.png', width: 100),
              ),
            ),
            const Text('Pokedex'),
          ],
        ),
      ),
      
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.4,
        ),

        itemCount: pokedex.length,
        itemBuilder: (context, index) {
          final pokemon = pokedex[index];
          final color = PokemonUtils.getTypeColor(pokemon['type'][0]);
          return GestureDetector(
            onTap: () => context.push('/detail', extra: pokemon),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset('lib/assets/pokeball.png', width: 100),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pokemon['name'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pokemon['type'][0],
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'lib/assets/pokeball.png',
                      image: pokemon['img'],
                      height: 80,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}