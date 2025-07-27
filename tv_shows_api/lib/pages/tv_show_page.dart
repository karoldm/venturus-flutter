import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/tv_shows.dart';
import 'package:tv_shows/widgets/tv_show_card.dart';

class TvShowPage extends StatefulWidget {
  const TvShowPage({super.key});

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final shows = context.watch<TvShowsProvider>().tvShows;
    return ListView.builder(
        itemBuilder: (context, index) {
          final tvShow = shows[index];
          return TvShowCard(tvShow: tvShow, index: index);
        },
        itemCount: shows.length);
  }
}
