import 'package:flutter_application_marvel/models/comic_response/comic_response.dart';

abstract class ComicRepository {
  Future<List<Comics>?> fetchComics(int offset);
  Future<Comics> fetchComicDetail(int comicId);
}
