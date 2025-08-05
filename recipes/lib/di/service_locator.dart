import 'package:get_it/get_it.dart';
import 'package:recipes/data/repositories/recipe_repository.dart';
import 'package:recipes/data/services/recipe_service.dart';
import 'package:recipes/ui/recipes/recipes_viewModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Supabase client
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // Recipe servive
  getIt.registerLazySingleton<RecipeService>(() => RecipeService());

  // Recipe repository
  getIt.registerLazySingleton<RecipeRepository>(() => RecipeRepository());

  // Recipe viewmodel
  getIt.registerFactory<RecipesViewModel>(() => RecipesViewModel());
}
