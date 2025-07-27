import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/pages/tv_show_form_page.dart';
import 'package:tv_shows/pages/tv_show_page.dart';
import 'package:tv_shows/providers/tv_shows.dart';
import 'package:tv_shows/widgets/layout.dart';
import 'package:tv_shows/widgets/not_found.dart';

final GoRouter routerConfig = GoRouter(initialLocation: '/', routes: [
  ShellRoute(builder: (context, state, child) => Layout(child: child), routes: [
    GoRoute(path: '/new', builder: (context, state) => const AddTvShowPage()),
    GoRoute(
        path: '/edit/:index',
        builder: (context, state) {
          try {
            final index = int.tryParse(state.pathParameters['index']!);
            final tvShow = context.read<TvShowsProvider>().tvShows[index!];
            return AddTvShowPage(
              initialData: tvShow,
            );
          } catch (e) {
            return const NotFound();
          }
        }),
    GoRoute(path: '/', builder: (context, state) => const TvShowPage()),
  ]),
]);
