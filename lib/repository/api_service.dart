import 'package:avaliacao_2/constants/api_constantis.dart';
import 'package:avaliacao_2/models/caracters.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Caracters>> getAllCharacters() async {
    try {
      var response = await _dio.get(ApiConstantis.allCharacterUrl);
      if (response.statusCode == 200) {
        return (response.data as List<dynamic>)
            .map((e) => Caracters.fromJson(e))
            .toList();
      }
    } catch (e) {
      throw Exception('Falha ao carregar os personagens: $e');
    }
    return [];
  }

  Future<Caracters?> getCharacterById(String id) async {
    try {
      var response = await _dio.get(ApiConstantis.characterUrl(id));
      if (response.statusCode == 200) {
        return Caracters.fromJson((response.data as List<dynamic>).first);
      }
    } catch (e) {
      throw Exception('Falha ao carregar personagem: $e');
    }
    return null;
  }
}
