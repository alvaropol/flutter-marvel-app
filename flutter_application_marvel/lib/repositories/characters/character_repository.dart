import 'package:flutter_application_marvel/models/character_response/character_response.dart';

abstract class CharacterRepository {
  Future<List<Character>?> fetchCharacterList();
  Future<Character> fetchCharacterDetail(int characterId);
}
