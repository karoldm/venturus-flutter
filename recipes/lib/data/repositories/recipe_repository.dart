import 'package:recipes/data/models/recipe.dart';
import 'package:recipes/data/services/recipe_service.dart';
import 'package:recipes/di/service_locator.dart';

class RecipeRepository {
  final RecipeService _recipeService = getIt<RecipeService>();

  Future<List<Recipe>> getRecipes() async {
    try {
      final data = await _recipeService.fetchRecipes();
      return data.map((json) => Recipe.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Falha ao carregar receitas: ${e.toString()}");
    }
  }
}
