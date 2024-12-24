import 'package:avaliacao_2/models/caracters.dart';
import 'package:avaliacao_2/repository/api_service.dart';
import 'package:flutter/foundation.dart';

class CharactersProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Caracters> _characters = [];
  Caracters? _selectedCharacter;
  bool _isLoading = false;

  List<Caracters> get characters => _characters;
  Caracters? get selectedCharacter => _selectedCharacter;
  bool get isLoading => _isLoading;

  Future<void> fetchCharacters() async {
    _isLoading = true;
    notifyListeners();

    try {
      _characters = await _apiService.getAllCharacters();
    } catch (e) {
      debugPrint('Error fetching characters: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCharacterById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedCharacter = await _apiService.getCharacterById(id);
    } catch (e) {
      debugPrint('Error fetching character by ID: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
