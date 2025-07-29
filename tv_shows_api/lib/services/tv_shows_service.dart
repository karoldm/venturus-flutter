import 'dart:convert';

import 'package:tv_shows/models/tv_show.dart';
import 'package:http/http.dart' as http;

class TvShowsService {
  Future<List<TvShow>> fetchTvShows(String query) async {
    final response = await http
        .get(Uri.parse("https://api.tvmaze.com/search/shows?q=$query"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((item) => TvShow.fromJson(item['show'] as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Falha ao carregar séries!');
    }
  }

  Future<TvShow> fetchTvShowById(String id) async {
    final response =
        await http.get(Uri.parse("https://api.tvmaze.com/shows/$id"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return TvShow.fromJson(jsonResponse);
    } else {
      throw Exception('Falha ao carregar série com ID: $id');
    }
  }
}
