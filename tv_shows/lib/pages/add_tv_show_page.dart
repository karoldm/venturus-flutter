import 'package:flutter/material.dart';
import 'package:tv_shows/models/tv_show.dart';
import 'package:tv_shows/widgets/star_rating.dart';

class AddTvShowPage extends StatefulWidget {
  final Function(TvShow newShow) onShowAdded;

  const AddTvShowPage({super.key, required this.onShowAdded});

  @override
  State<AddTvShowPage> createState() => _AddTvShowPageState();
}

class _AddTvShowPageState extends State<AddTvShowPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  int _rating = 0;
  final _streamController = TextEditingController();

  void submit() {
    if (_formKey.currentState!.validate()) {
      final newShow = TvShow(
        title: _titleController.text,
        summary: _summaryController.text,
        rating: _rating,
        stream: _streamController.text,
      );

      widget.onShowAdded(newShow);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Série "${newShow.title}" adicionada com sucesso!',
          ),
        ),
      );

      setState(() {
        _formKey.currentState?.reset();
        _rating = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Adicionar nova série",
              style: TextStyle(
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
                    onPressed: submit,
                    child: const Text("Adicionar"),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
