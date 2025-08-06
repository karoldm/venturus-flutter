import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/core/router.dart';
import 'package:tv_shows/providers/theme_app.dart';
import 'package:tv_shows/providers/tv_shows.dart';
import 'package:tv_shows/core/theme.dart';

void main() {
  // garante que o Flutter seja inicializado antes de executar qualquer código
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<TvShowsProvider>(
        create: (context) => TvShowsProvider(),
      ),
      ChangeNotifierProvider<AppThemeProvider>(
        create: (context) => AppThemeProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
      title: 'TV Shows',
      theme: customTheme,
      darkTheme: customThemeDark,
      themeMode: context.watch<AppThemeProvider>().themeMode,
    );
  }
}
