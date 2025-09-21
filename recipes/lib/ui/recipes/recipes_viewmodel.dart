import 'package:get/get.dart';
import 'package:recipes/data/models/recipe.dart';
import 'package:recipes/data/repositories/auth_repository.dart';
import 'package:recipes/data/repositories/recipe_repository.dart';
import 'package:recipes/di/service_locator.dart';
import 'package:recipes/l10n/app_localizations.dart';

class RecipesViewModel extends GetxController {
  final RecipeRepository _recipeRepository = getIt<RecipeRepository>();
  final AuthRepository _authRepository = getIt<AuthRepository>();
  String userId = '';

  final RxList<Recipe> _favRecipes = <Recipe>[].obs;
  final RxList<Recipe> _recipes = <Recipe>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  List<Recipe> get favRecipes => _favRecipes;
  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;

  Future<void> loadRecipes(AppLocalizations l10n) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      _recipes.value = await _recipeRepository.getRecipes();

      userId = '';
      await _authRepository.currentUser.then(
        (result) => result.fold(
          ifLeft: (left) => _errorMessage.value = left.message,
          ifRight: (right) => userId = right.id,
        ),
      );
      _favRecipes.value = await _recipeRepository.getFavRecipes(userId);
    } catch (error) {
      _errorMessage.value = "${l10n.errorListingRecipes}: ${error.toString()}";
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> toggleFavorite(Recipe recipe, AppLocalizations l10n) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      if (_favRecipes.any((fav) => fav.id == recipe.id)) {
        await _recipeRepository.deleteFavRecipe(recipe.id, userId);
        _favRecipes.removeWhere((fav) => fav.id == recipe.id);
      } else {
        await _recipeRepository.insertFavRecipe(recipe.id, userId);
        _favRecipes.add(recipe);
      }
    } catch (error) {
      _errorMessage.value =
          "${l10n.errorToUpdateFavorite}: ${error.toString()}";
    } finally {
      _isLoading.value = false;
    }
  }
}
