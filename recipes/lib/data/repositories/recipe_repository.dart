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

  Future<Recipe?> getRecipeById(String id) async {
    final rawData = await _recipeService.fetchRecipeById(id);
    return rawData != null ? Recipe.fromJson(rawData) : null;
  }

  Future<List<Recipe>> getFavRecipes(String userId) async {
    final rawData = await _recipeService.fetchFavRecipes(userId);
    return rawData
        .where((data) => data['recipes'] != null)
        .map((data) => Recipe.fromJson(data['recipes'] as Map<String, dynamic>))
        .toList();
  }

  Future<void> insertFavRecipe(String recipeId, String userId) async {
    await _recipeService.insertFavRecipe(recipeId, userId);
  }

  Future<void> deleteFavRecipe(String recipeId, String userId) async {
    await _recipeService.deleteFavRecipe(recipeId, userId);
  }
}
