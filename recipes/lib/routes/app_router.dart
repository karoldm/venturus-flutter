import 'package:flutter/cupertino.dart';
import 'package:recipes/data/services/auth_service.dart';
import 'package:recipes/di/service_locator.dart';
import 'package:recipes/ui/auth/auth_view.dart';
import 'package:recipes/ui/base_screen.dart';
import 'package:recipes/ui/favorites/favorites_view.dart';
import 'package:recipes/ui/profile/profile_view.dart';
import 'package:recipes/ui/recipe_details/recipe_details_view.dart';
import 'package:recipes/ui/recipes/recipes_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router;

  final _service = getIt<AuthService>();

  late final ValueNotifier<bool> _authStateNotifier;

  AppRouter() {
    _authStateNotifier = ValueNotifier<bool>(_service.currentUser != null);
    // authStateChanges é um Stream que emite eventos
    // quando o estado de autenticação muda
    _service.authStateChanges.listen((state) async {
      // quando o estado de autenticação muda,
      // atualizamos o notifier com o novo estado
      // para que ele possa fazer um refresh do GoRouter
      _authStateNotifier.value = _service.currentUser != null;
    });

    router = GoRouter(
      initialLocation: '/',
      // refreshListenable é usado para atualizar o GoRouter
      // e realizar redirects se necessário
      refreshListenable: _authStateNotifier,
      routes: [
        ShellRoute(
          builder: (context, state, child) => BaseScreen(child: child),
          routes: [
            GoRoute(path: '/', builder: (context, state) => RecipesView()),
            GoRoute(path: '/auth', builder: (context, state) => AuthView()),
            GoRoute(
              path: '/recipe/:id',
              builder: (context, state) {
                final recipeId = state.pathParameters['id']!;
                return RecipeDetailsView(id: recipeId);
              },
            ),
            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                return FavoritesView();
              },
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) {
                return ProfileView();
              },
            ),
          ],
        ),
      ],
      // toda vez que o usuário tentar acessar uma rota ou
      // rolar um refresh do GoRouter, o redirect será chamado.
      redirect: (context, state) {
        final isLoggedIn = _authStateNotifier.value;
        final currentPath = state.uri.path;
        if (!isLoggedIn && currentPath != '/auth') {
          return '/auth';
        }

        if (isLoggedIn && currentPath == '/auth') {
          return '/';
        }

        return null; // Sem redirecionamento, deixa o usuário na rota que quer
      },
    );
  }
}
