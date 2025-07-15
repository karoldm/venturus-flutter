import 'package:flutter/material.dart';
import 'package:tv_shows/components/rating.dart';
import 'package:tv_shows/mocks/tv_shows_data.dart';
import 'package:tv_shows/models/tv_show.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TV Shows',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const TvShowPage(),
    );
  }
}

class TvShowPage extends StatefulWidget {
  const TvShowPage({super.key});

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  List<TvShow> showsList = favTvShowList;
  final TextEditingController searchController = TextEditingController();
  String filter = '';

  void filterShows(String query) {
    setState(() {
      filter = query.toLowerCase();
      showsList = favTvShowList
          .where((show) => show.title.toLowerCase().contains(filter))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Stream Me',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      hintText: 'Search TV Shows',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(color: Colors.grey.shade600),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    controller: searchController,
                    onChanged: filterShows,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            final tvShow = showsList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                titleTextStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: Colors.black12, width: 1)),
                contentPadding: const EdgeInsets.all(8),
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: Text(tvShow.title),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Rating(rating: tvShow.rating),
                    const SizedBox(height: 4),
                    Text(tvShow.summary,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54)),
                  ],
                ),
                isThreeLine: true,
                trailing: Container(
                  width: 90,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade600),
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    tvShow.stream,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(tvShow.title),
                      content: const Text(
                          'Redirecionando para o serviço de streaming...'),
                    ),
                  );
                },
              ),
            );
          },
          itemCount: showsList.length),
    );
  }
}
