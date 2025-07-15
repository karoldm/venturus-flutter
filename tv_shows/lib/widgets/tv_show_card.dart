import 'package:flutter/material.dart';
import 'package:tv_shows/widgets/rating.dart';
import 'package:tv_shows/models/tv_show.dart';

class TvShowCard extends StatelessWidget {
  final TvShow tvShow;
  final int index;

  const TvShowCard({super.key, required this.tvShow, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        titleTextStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        contentPadding: const EdgeInsets.all(8),
        leading: Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
          label: Text(
            index.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        title: Text(tvShow.title),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Rating(rating: tvShow.rating),
            const SizedBox(height: 4),
            Text(tvShow.summary,
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
        isThreeLine: true,
        trailing: Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.all(4),
          label: Text(
            tvShow.stream,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
