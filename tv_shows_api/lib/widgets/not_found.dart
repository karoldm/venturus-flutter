import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              children: [
                Text(
                  "404",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 8),
                Text("Página não encontrada",
                    style: TextStyle(fontSize: 16, color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
              icon: const Icon(Icons.home),
              onPressed: () {
                context.go('/');
              },
              label: const Text(
                "Voltar para home",
              ))
        ],
      ),
    ));
  }
}
