import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/tv_show.dart';
import 'package:tv_shows/providers/tv_shows.dart';
import 'package:tv_shows/widgets/tv_show_grid.dart';

class TvShowSearchPage extends StatefulWidget {
  const TvShowSearchPage({super.key});

  @override
  State<TvShowSearchPage> createState() => _TvShowSearchPageState();
}

class _TvShowSearchPageState extends State<TvShowSearchPage> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  bool _onSubmit = false;
  late Future<List<TvShow>>? _future;

  void submit() {
    if (_formKey.currentState!.validate()) {
      final provider = context.read<TvShowsProvider>();
      final result = provider.searchTvShows(_searchController.text);
      setState(() {
        _future = result;
        _onSubmit = true;
      });
    }
  }

  void clear() {
    setState(() {
      _searchController.clear();
      _onSubmit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Buscar séries",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 32),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.search), onPressed: submit),
                    _onSubmit
                        ? IconButton(
                            icon: const Icon(Icons.clear), onPressed: clear)
                        : const SizedBox.shrink()
                  ],
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Título é obrigatório!';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          _onSubmit
              ? Expanded(
                  child: FutureBuilder<List<TvShow>>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                      Text(
                                          'Erro ao buscar séries: ${snapshot.error}',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.red[500])),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: () => context.go('/'),
                                        child: const Text('Voltar'),
                                      )
                                    ],
                                  )));
                        }
                        if (_onSubmit &&
                            (!snapshot.hasData || snapshot.data!.isEmpty)) {
                          return Center(
                              child: Container(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    children: [
                                      const Text('Nenhuma série encontrada',
                                          style: TextStyle(fontSize: 24)),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: () => context.go('/'),
                                        child: const Text('Voltar'),
                                      )
                                    ],
                                  )));
                        }

                        return TvShowGrid(tvShows: snapshot.data ?? []);
                      }),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
