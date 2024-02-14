import 'package:flutter_application_marvel/models/character_response/character_response.dart';
import 'package:flutter_application_marvel/models/character_response/detail_character_response.dart';

abstract class CharacterRepository {
  Future<List<Character>?> fetchCharacterList(int offset);
  Future<List<Results>?> fetchCharacterDetail(int characterId);
}
