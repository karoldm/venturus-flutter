import 'package:flutter/material.dart';
import 'package:tv_shows/models/tv_show.dart';
import 'package:tv_shows/services/tv_shows_service.dart';

class TvShowsProvider extends ChangeNotifier {
  late final TvShowsService _service;

  TvShowsProvider() {
    _service = TvShowsService();
    initialize();
  }

  List<TvShow> _favoriteTvShows = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TvShow> get favoriteTvShows => _favoriteTvShows;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasFavorites => _favoriteTvShows.isNotEmpty;

// local database
  Future<void> initialize() async {
    await load();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> load() async {
    try {
      _setLoading(true);
      _setError(null);
      _favoriteTvShows = await _service.getAll();
    } catch (e) {
      _setError('Falha ao carregar séries favoritas: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addToFavorites(TvShow tvShow) async {
    await _service.insert(tvShow);
    _favoriteTvShows.add(tvShow);
    notifyListeners();
  }

  Future<void> removeFromFavorites(TvShow tvShow) async {
    await _service.delete(tvShow.id);
    _favoriteTvShows.removeWhere((show) => show.id == tvShow.id);
    notifyListeners();
  }

  Future<bool> isFavorite(TvShow tvShow) async {
    try {
      return await _service.isFavorite(tvShow);
    } catch (e) {
      _setError('Falha em verificar se é favorita: ${e.toString()}');
      return false;
    }
  }

  void sortByName(bool ascending) {
    _favoriteTvShows.sort(
      (a, b) => ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name),
    );
    notifyListeners();
  }

  void sortByRating(bool ascending) {
    _favoriteTvShows.sort(
      (a, b) => ascending
          ? a.rating.compareTo(b.rating)
          : b.rating.compareTo(a.rating),
    );
    notifyListeners();
  }

  // external API

  Future<List<TvShow>> searchTvShows(String query) async {
    try {
      final shows = await _service.fetchTvShows(query);
      return shows;
    } catch (e) {
      debugPrint('Erro ao buscar séries: $e');
      rethrow;
    }
  }

  Future<TvShow> fetchTvShowById(String id) async {
    try {
      final tvShow = await _service.fetchTvShowById(id);
      return tvShow;
    } catch (e) {
      debugPrint('Erro ao buscar série por ID: $e');
      rethrow;
    }
  }
}
