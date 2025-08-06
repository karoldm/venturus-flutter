import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:tv_shows/models/tv_show.dart';
import 'package:http/http.dart' as http;
import 'package:tv_shows/services/database_service.dart';

class TvShowsService {
  // Local database
  late final DatabaseService _databaseService = DatabaseService();

  Future<List<TvShow>> getAll() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('fav_tv_shows');
    return _convertToList(maps);
  }

  List<TvShow> _convertToList(List<Map<String, dynamic>> maps) {
    return maps
        .map(
          (map) => TvShow(
            id: map['id'] as int,
            imageUrl: map['imageUrl'] as String? ?? '',
            name: map['name'] as String? ?? 'Desconhecido',
            webChannel: map['webChannel'] as String? ?? 'N/A',
            rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
            summary: map['summary'] as String? ?? 'Sem resumo disponível.',
          ),
        )
        .toList();
  }

  Future<void> insert(TvShow tvShow) async {
    final db = await _databaseService.database;
    await db.insert(
      'fav_tv_shows',
      tvShow.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(int id) async {
    final db = await _databaseService.database;
    await db.delete('fav_tv_shows', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(TvShow tvShow) async {
    final tvShows = await getAll();
    return tvShows.any((show) => show.id == tvShow.id);
  }

  // external API

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
