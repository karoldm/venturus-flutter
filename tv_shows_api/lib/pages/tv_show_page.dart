import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/tv_show.dart';
import 'package:tv_shows/providers/tv_shows.dart';

class TvShowPage extends StatefulWidget {
  final String id;
  const TvShowPage({super.key, required this.id});

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  late Future<TvShow>? _future;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TvShowsProvider>();
    _future = provider.fetchTvShowById(widget.id);

    return FutureBuilder<TvShow>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SizedBox(
              height: 96,
              width: 96,
              child: CircularProgressIndicator(strokeWidth: 12),
            ));
          }
          if (snapshot.hasError) {
            return Center(
                child: Container(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Text('Erro ao buscar série: ${snapshot.error}',
                            style: TextStyle(
                                fontSize: 24, color: Colors.red[500])),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.go('/'),
                          child: const Text('Voltar'),
                        )
                      ],
                    )));
          }
          if (!snapshot.hasData) {
            return Center(
                child: Container(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        const Text('Série não encontrada',
                            style: TextStyle(fontSize: 24)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.go('/'),
                          child: const Text('Voltar'),
                        )
                      ],
                    )));
          }

          final tvShow = snapshot.data!;
          final isFavorite =
              provider.favoriteTvShows.any((show) => show.id == widget.id);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.network(
                      tvShow.imageUrl,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : Center(
                                  child: CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                      errorBuilder: (context, child, stackTrace) => Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Theme.of(context).colorScheme.primary,
                        child: const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tvShow.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Chip(
                          label: Text(tvShow.webChannel),
                          shape: const StadiumBorder()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 24),
                      Text(
                        tvShow.rating.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(tvShow.summary),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      label: Text(isFavorite ? 'Desfavoritar' : 'Favoritar'),
                      onPressed: () {
                        if (isFavorite) {
                          provider.removeFavoriteTvShow(tvShow, context);
                        } else {
                          provider.addFavoriteTvShow(tvShow, context);
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                      )),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      label: const Text('Voltar'),
                      onPressed: () {
                        context.go('/search');
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      )),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        });
  }
}
