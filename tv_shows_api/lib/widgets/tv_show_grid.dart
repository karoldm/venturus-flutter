import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/tv_show.dart';
import 'package:tv_shows/providers/tv_shows.dart';

class TvShowGrid extends StatefulWidget {
  const TvShowGrid({super.key, required this.tvShows});

  final List<TvShow> tvShows;

  @override
  State<TvShowGrid> createState() => _TvShowGridState();
}

class _TvShowGridState extends State<TvShowGrid> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TvShowsProvider>();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemCount: widget.tvShows.length,
      itemBuilder: (context, index) {
        final tvShow = widget.tvShows[index];
        final isFavorite =
            provider.favoriteTvShows.any((show) => show.id == tvShow.id);
        return Stack(
          children: [
            GestureDetector(
              onTap: () => context.go('/tv-show/${tvShow.id}'),
              child: Card(
                elevation: 5,
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        child: Image.network(
                          tvShow.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                          errorBuilder: (context, child, stackTrace) =>
                              Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Theme.of(context).colorScheme.primary,
                            child: const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(tvShow.name),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 18),
                              Text(
                                tvShow.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                  style: IconButton.styleFrom(backgroundColor: Colors.black54),
                  onPressed: () {
                    if (isFavorite) {
                      provider.removeFavoriteTvShow(tvShow, context);
                    } else {
                      provider.addFavoriteTvShow(tvShow, context);
                    }
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                  )),
            )
          ],
        );
      },
    );
  }
}
