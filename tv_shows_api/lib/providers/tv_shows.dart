import 'package:flutter/material.dart';
import 'package:tv_shows/models/tv_show.dart';

class TvShowsProvider extends ChangeNotifier {
  final List<TvShow> _tvShows = [];

  List<TvShow> get tvShows => _tvShows;

  void addTvShow(TvShow tvShow, BuildContext context) {
    _tvShows.add(tvShow);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green[600],
        content: Text(
          'Série "${tvShow.title}" adicionada com sucesso!',
        ),
      ),
    );
    notifyListeners();
  }

  void removeTvShow(TvShow tvShow, BuildContext context) {
    _tvShows.remove(tvShow);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tvShow.title} Removido.'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            _tvShows.add(tvShow);
            notifyListeners();
          },
        ),
      ),
    );
    notifyListeners();
  }

  void editTvShow(
      TvShow currentTvShow, TvShow updatedTvShow, BuildContext context) {
    final index = _tvShows.indexOf(currentTvShow);
    _tvShows[index] = updatedTvShow;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Série atualizada.'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            _tvShows[index] = currentTvShow;
            notifyListeners();
          },
        ),
      ),
    );

    notifyListeners();
  }
}
