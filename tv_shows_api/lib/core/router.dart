import 'package:go_router/go_router.dart';
import 'package:tv_shows/pages/favorite_page.dart';
import 'package:tv_shows/pages/tv_show_page.dart';
import 'package:tv_shows/pages/tv_show_search_page.dart';
import 'package:tv_shows/widgets/layout.dart';

final GoRouter routerConfig = GoRouter(initialLocation: '/search', routes: [
  ShellRoute(builder: (context, state, child) => Layout(child: child), routes: [
    GoRoute(
        path: '/search', builder: (context, state) => const TvShowSearchPage()),
    GoRoute(
        path: '/tv-show/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TvShowPage(id: id);
        }),
    GoRoute(path: '/', builder: (context, state) => const FavoritePage()),
  ]),
]);
