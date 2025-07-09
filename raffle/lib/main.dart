import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raffle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _randNum = 0;
  String _text = '???';
  final List<int> _numbers = [];
  String _alertText = '';

  void _generateRand() {
    setState(() {
      _randNum = Random().nextInt(10);
      _text = _randNum.toString();
      if (_numbers.contains(_randNum)) {
        _alertText = 'Número $_randNum já sorteado!';
      } else {
        _alertText = '';
        _numbers.add(_randNum);
      }
    });
  }

  void _reset() {
    setState(() {
      _text = '???';
      _numbers.clear();
      _alertText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purpleAccent.shade700,
        title: const Text(
          "Hoje é seu dia de sorte! 🎲",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _text,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              Text(_alertText,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateRand,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent.shade700,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("Sortear"),
              ),
              const SizedBox(height: 20),
              Text(
                'Números já sorteados: ${_numbers.join(', ')}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reset,
        backgroundColor: Colors.black87,
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }
}
