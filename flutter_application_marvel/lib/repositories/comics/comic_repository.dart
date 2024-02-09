import 'package:flutter_application_marvel/models/comic_response/comic_response.dart';

abstract class ComicRepository {
  Future<List<Comics>> fetchComics();
  Future<Comics> fetchComicDetail(int comicId);
}
