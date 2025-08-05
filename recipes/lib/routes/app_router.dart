import 'package:recipes/ui/base_screen.dart';
import 'package:recipes/ui/recipes/recipes_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
          builder: (context, state, child) => BaseScreen(child: child),
          routes: [
            GoRoute(path: '/', builder: (context, state) => RecipesView()),
          ],
        ),
      ],
    );
  }
}
