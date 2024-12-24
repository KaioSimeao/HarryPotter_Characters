import 'package:avaliacao_2/constants/my_colors.dart';
import 'package:avaliacao_2/providers/characters_provider.dart';
import 'package:avaliacao_2/screens/character_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final charactersProvider =
        Provider.of<CharactersProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      charactersProvider.fetchCharacters();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personagens de Harry Potter',
          style: TextStyle(
            color: Color(0xFFDABA8F),
          ),
        ),
      ),
      body: Consumer<CharactersProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.grey[50],
            ));
          }

          if (provider.characters.isEmpty) {
            return const Center(child: Text('Personagens não encontrados.'));
          }

          return ListView.builder(
            itemCount: provider.characters.length,
            itemBuilder: (context, index) {
              final character = provider.characters[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CharacterDetailScreen(id: character.id ?? ''),
                    ),
                  );
                },
                child: Container(
                  height: 100,
                  color: MyColors.corCard,
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      character.image != null && character.image!.isNotEmpty
                          ? Container(
                              width: 90,
                              height: 90,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: MyColors.corTextos,
                                width: 2,
                              )),
                              child: Image.network(
                                character.image!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 100,
                              color: MyColors.corTextos,
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.name != null && character.name!.isNotEmpty
                                ? '${character.name}'
                                : 'Não indetificada',
                            style: const TextStyle(
                                color: MyColors.corTextos, fontSize: 30),
                          ),
                          Text(
                            character.house != null &&
                                    character.house!.isNotEmpty
                                ? '${character.house}'
                                : 'Casa não indetificada',
                            style: const TextStyle(
                                color: MyColors.corTextos, fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
