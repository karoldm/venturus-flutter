import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/tv_show.dart';
import 'package:tv_shows/providers/tv_shows.dart';
import 'package:tv_shows/widgets/star_rating.dart';

class AddTvShowPage extends StatefulWidget {
  final TvShow? initialData;

  const AddTvShowPage({super.key, this.initialData});

  @override
  State<AddTvShowPage> createState() => _AddTvShowPageState();
}

class _AddTvShowPageState extends State<AddTvShowPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  final _streamController = TextEditingController();
  int _rating = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _summaryController.dispose();
    _streamController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialData != null) {
      _titleController.text = widget.initialData!.title;
      _summaryController.text = widget.initialData!.summary;
      _rating = widget.initialData!.rating;
      _streamController.text = widget.initialData!.stream;
    }
  }

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final newShow = TvShow(
        title: _titleController.text,
        summary: _summaryController.text,
        rating: _rating,
        stream: _streamController.text,
      );

      widget.initialData != null
          ? context
              .read<TvShowsProvider>()
              .editTvShow(widget.initialData!, newShow, context)
          : context.read<TvShowsProvider>().addTvShow(newShow, context);

      setState(() {
        _formKey.currentState?.reset();
        _rating = 0;
      });

      if (context.mounted) {
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialData != null;
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              isEdit ? "Editar série" : "Adicionar nova série",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Título",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o título da série';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _summaryController,
                    decoration: const InputDecoration(
                      labelText: "Resumo",
                      border: OutlineInputBorder(),
                    ),
                    minLines: 1,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um resumo para a série';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _streamController,
                    decoration: const InputDecoration(
                      labelText: "Plataforma de Streaming",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a plataforma de streaming';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        "Nota",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      StarRating(
                        initialRating: _rating,
                        onRatingChanged: (rating) {
                          _rating = rating;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () => submit(context),
                    child: const Text("Salvar"),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
