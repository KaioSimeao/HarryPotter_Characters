import 'package:avaliacao_2/providers/characters_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterDetailScreen extends StatefulWidget {
  final String id;

  const CharacterDetailScreen({super.key, required this.id});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchCharacterDetails());
  }

  Future<void> _fetchCharacterDetails() async {
    final charactersProvider =
        Provider.of<CharactersProvider>(context, listen: false);
    await charactersProvider.fetchCharacterById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: MyColors.corTextos),
        title: const Text(
          'Detalhes do Personagem',
          style: TextStyle(color: MyColors.corTextos),
        ),
      ),
      body: Consumer<CharactersProvider>(
        builder: (context, charactersProvider, _) {
          if (charactersProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final character = charactersProvider.selectedCharacter;

          if (character == null) {
            return const Center(child: Text('Personagem não encontrado.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (character.image != null && character.image!.isNotEmpty)
                    ? Image.network(character.image!)
                    : const Icon(Icons.person, size: 100),
                const SizedBox(height: 16),
                Text('Nome: ${character.name}',
                    style: const TextStyle(fontSize: 18)),
                Text('Casa: ${character.house}',
                    style: const TextStyle(fontSize: 16)),
                Text('Ator: ${character.actor}',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
