import 'package:get_it/get_it.dart';
import 'package:recipes/data/repositories/auth_repository.dart';
import 'package:recipes/data/repositories/recipe_repository.dart';
import 'package:recipes/data/services/auth_service.dart';
import 'package:recipes/data/services/recipe_service.dart';
import 'package:recipes/ui/auth/auth_viewmodel.dart';
import 'package:recipes/ui/profile/profile_viewmodel.dart';
import 'package:recipes/ui/recipe_details/recipe_details_viewmodel.dart';
import 'package:recipes/ui/recipes/recipes_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Supabase client
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // Services
  getIt.registerLazySingleton<RecipeService>(() => RecipeService());
  getIt.registerLazySingleton<AuthService>(() => AuthService());

  // Repositories
  getIt.registerLazySingleton<RecipeRepository>(() => RecipeRepository());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());

  // ViewModels
  getIt.registerLazySingleton<RecipesViewModel>(() => RecipesViewModel());
  getIt.registerLazySingleton<RecipeDetailViewModel>(
    () => RecipeDetailViewModel(),
  );
  getIt.registerLazySingleton<AuthViewModel>(() => AuthViewModel());
  getIt.registerLazySingleton<ProfileViewModel>(() => ProfileViewModel());
}
