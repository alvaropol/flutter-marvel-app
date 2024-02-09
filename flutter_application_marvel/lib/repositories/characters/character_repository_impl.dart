import 'dart:convert';

import 'package:flutter_application_marvel/models/character_response/character_response.dart';
import 'package:flutter_application_marvel/repositories/characters/character_repository.dart';
import 'package:http/http.dart';

class CharacterRepositoryImpl extends CharacterRepository {
  final Client _httpClient = Client();

  @override
  Future<List<Character>?> fetchCharacterList(int offset) async {
    final response = await _httpClient.get(Uri.parse(
        'https://gateway.marvel.com/v1/public/characters?ts=1&apikey=73d03ea66b154cd4d860e01c3e78e33c&hash=0b5a97a285f74eaa0658001b5127b3ce&offset=$offset'));
    if (response.statusCode == 200) {
      return CharacterResponse.fromJson(json.decode(response.body))
          .data
          ?.results;
    } else {
      throw Exception('Failed to load character list');
    }
  }

  @override
  Future<Character> fetchCharacterDetail(int characterId) {
    throw UnimplementedError();
  }
}
