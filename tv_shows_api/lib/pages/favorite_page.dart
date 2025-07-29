import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/tv_shows.dart';
import 'package:tv_shows/widgets/tv_show_grid.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tvShows = context.watch<TvShowsProvider>().favoriteTvShows;

    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              tvShows.isEmpty ? "Nenhuma série favoritada" : "Séries Favoritas",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 16),
            Expanded(child: TvShowGrid(tvShows: tvShows)),
          ],
        ));
  }
}
