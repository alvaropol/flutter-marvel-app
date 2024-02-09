import 'dart:convert';

import 'package:flutter_application_marvel/models/comic_response/comic_response.dart';
import 'package:flutter_application_marvel/repositories/comics/comic_repository.dart';
import 'package:http/http.dart';

class ComicRepositoryImpl extends ComicRepository {
  Client _httpClient = Client();

  @override
  Future<Comics> fetchComicDetail(int comicId) {
    // TODO: implement fetchComicDetail
    throw UnimplementedError();
  }

  @override
  Future<List<Comics>> fetchComics() async {
    final response = await _httpClient.get(Uri.parse(
        "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=73d03ea66b154cd4d860e01c3e78e33c&hash=0b5a97a285f74eaa0658001b5127b3ce"));
    if (response.statusCode == 200) {
      final jsonValue = json.decode(response.body);
      return ComicsResponse.fromJson(jsonValue).data!.results!;
    } else {
      throw Exception('failed');
    }
  }
}
