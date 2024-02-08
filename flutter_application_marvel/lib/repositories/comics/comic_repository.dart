import 'package:flutter_application_marvel/models/character_response/character_response.dart';

abstract class ComicRepository {
  Future<List<Comics>> fetchComics();
  Future<Comics> fetchComicDetail(int comicId);
}
