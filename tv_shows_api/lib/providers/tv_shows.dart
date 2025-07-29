import 'package:flutter/material.dart';
import 'package:tv_shows/models/tv_show.dart';
import 'package:tv_shows/services/tv_shows_service.dart';

class TvShowsProvider extends ChangeNotifier {
  final TvShowsService _service = TvShowsService();
  final List<TvShow> _favoriteTvShows = [];

  List<TvShow> get favoriteTvShows => _favoriteTvShows;

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

  void addFavoriteTvShow(TvShow tvShow, BuildContext context) {
    favoriteTvShows.add(tvShow);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Série adicionada com sucesso!',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  void removeFavoriteTvShow(TvShow tvShow, BuildContext context) {
    final index = favoriteTvShows.indexWhere(
      (show) => show.name.toLowerCase() == tvShow.name.toLowerCase(),
    );
    favoriteTvShows.removeAt(index);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tvShow.name} excluída!'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            favoriteTvShows.insert(index, tvShow);
            notifyListeners();
          },
        ),
      ),
    );
    notifyListeners();
  }
}
