import 'package:flutter/material.dart';
import 'package:tv_shows/components/tv_show_card.dart';
import 'package:tv_shows/models/tv_show.dart';

class TvShowPage extends StatefulWidget {
  final List<TvShow> showsList;
  const TvShowPage({super.key, required this.showsList});

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          final tvShow = widget.showsList[index];
          return TvShowCard(tvShow: tvShow, index: index + 1);
        },
        itemCount: widget.showsList.length);
  }
}
