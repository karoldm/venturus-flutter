import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/tv_shows.dart';
import 'package:tv_shows/widgets/tv_show_grid.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TvShowsProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TvShowsProvider>(
      builder: (context, snapshot, child) {
        if (snapshot.isLoading) {
          return const Center(
            child: SizedBox(
              height: 96,
              width: 96,
              child: CircularProgressIndicator(strokeWidth: 12),
            ),
          );
        }

        if (snapshot.errorMessage != null) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                spacing: 32,
                children: [
                  Text(
                    'Erro: ${snapshot.errorMessage}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      snapshot.load();
                    },
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (snapshot.hasFavorites) ...[
                const SizedBox(height: 8),
                Text(
                  '${snapshot.favoriteTvShows.length} série(s) favorita(s)',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
              const SizedBox(height: 16),
              Expanded(
                child: snapshot.hasFavorites
                    ? TvShowGrid(tvShows: snapshot.favoriteTvShows)
                    : Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 64),
                            Icon(
                              Icons.favorite,
                              size: 96,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 32),
                            const Text(
                              'Adicione suas séries favoritas!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
