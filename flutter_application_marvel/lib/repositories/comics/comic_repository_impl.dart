import 'dart:convert';
import 'package:flutter_application_marvel/models/comic_detail/comic_detail.dart';
import 'package:flutter_application_marvel/models/comic_response/comic_response.dart';
import 'package:flutter_application_marvel/repositories/comics/comic_repository.dart';
import 'package:http/http.dart' as http;

class ComicRepositoryImpl extends ComicRepository {
  final http.Client _httpClient = http.Client();

  @override
  Future<List<Comic>> fetchComicDetail(int comicId) async {
    final response = await _httpClient.get(Uri.parse(
        'https://gateway.marvel.com/v1/public/comics/$comicId?ts=1&apikey=73d03ea66b154cd4d860e01c3e78e33c&hash=0b5a97a285f74eaa0658001b5127b3ce'));
    if (response.statusCode == 200) {
      final comicResponse = ComicResponse.fromJson(json.decode(response.body));
      return comicResponse.data.results;
    } else {
      throw Exception('Failed to fetch comic');
    }
  }

  @override
  Future<List<Comics>?> fetchComics(int offset) async {
    final response = await _httpClient.get(Uri.parse(
        "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=73d03ea66b154cd4d860e01c3e78e33c&hash=0b5a97a285f74eaa0658001b5127b3ce&offset=$offset"));
    if (response.statusCode == 200) {
      // Assuming your ComicsResponse and Comics classes are correctly set up to parse the comics JSON data
      final comicsResponse =
          ComicsResponse.fromJson(json.decode(response.body));
      return comicsResponse.data.results;
    } else {
      throw Exception('Failed to fetch comics');
    }
  }
}
