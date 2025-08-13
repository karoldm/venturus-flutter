import 'package:get/get.dart';
import 'package:recipes/data/models/recipe.dart';
import 'package:recipes/data/repositories/recipe_repository.dart';
import 'package:recipes/di/service_locator.dart';

class RecipesViewModel extends GetxController {
  final RecipeRepository _recipeRepository = getIt<RecipeRepository>();

  final RxList<Recipe> _recipes = <Recipe>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;

  Future<void> loadRecipes() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      _recipes.value = await _recipeRepository.getRecipes();
    } catch (error) {
      _errorMessage.value = "Falha ao carregar receitas: ${error.toString()}";
    } finally {
      _isLoading.value = false;
    }
  }
}
