import 'package:recipes/data/models/recipe.dart';
import 'package:recipes/data/repositories/auth_repository.dart';
import 'package:recipes/data/repositories/recipe_repository.dart';
import 'package:recipes/di/service_locator.dart';
import 'package:get/get.dart';
import 'package:recipes/l10n/app_localizations.dart';

class RecipeDetailViewModel extends GetxController {
  final _repository = getIt<RecipeRepository>();
  final _authRepository = getIt<AuthRepository>();

  final Rxn<Recipe> _recipe = Rxn<Recipe>();
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxBool _isFavorite = false.obs;

  Recipe? get recipe => _recipe.value;
  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;
  bool get isFavorite => _isFavorite.value;

  Future<void> loadRecipe(String id, AppLocalizations l10n) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      _recipe.value = await _repository.getRecipeById(id);
      var userId = '';
      await _authRepository.currentUser.then(
        (result) => result.fold(
          ifLeft: (left) => _errorMessage.value = left.message,
          ifRight: (right) => userId = right.id,
        ),
      );
      _isFavorite.value = await isRecipeFavorite(id, userId, l10n);
    } catch (e) {
      _errorMessage.value = '${l10n.errorToFondRecipe}: ${e.toString()}';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> isRecipeFavorite(
    String recipeId,
    String userId,
    AppLocalizations l10n,
  ) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      final favRecipes = await _repository.getFavRecipes(userId);
      return favRecipes.any((recipe) => recipe.id == recipeId);
    } catch (e) {
      _errorMessage.value =
          '${l10n.errorToFoundFavoriteRecipe}: ${e.toString()}';
    } finally {
      _isLoading.value = false;
    }
    return false;
  }

  Future<void> toggleFavorite(AppLocalizations l10n) async {
    var userId = '';
    await _authRepository.currentUser.then(
      (result) => result.fold(
        ifLeft: (left) => _errorMessage.value = left.message,
        ifRight: (right) => userId = right.id,
      ),
    );
    final recipeId = recipe!.id;

    if (_isFavorite.value) {
      await removeFromFavorites(recipeId, userId, l10n);
    } else {
      await addToFavorites(recipeId, userId, l10n);
    }
  }

  Future<void> addToFavorites(
    String recipeId,
    String userId,
    AppLocalizations l10n,
  ) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      await _repository.insertFavRecipe(recipeId, userId);
      _isFavorite.value = true;
    } catch (e) {
      _errorMessage.value = '${l10n.errorToAddFavorite}: ${e.toString()}';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> removeFromFavorites(
    String recipeId,
    String userId,
    AppLocalizations l10n,
  ) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      await _repository.deleteFavRecipe(recipeId, userId);
      _isFavorite.value = false;
    } catch (e) {
      _errorMessage.value = '${l10n.errorToRemoveFavorite}: ${e.toString()}';
    } finally {
      _isLoading.value = false;
    }
  }
}
