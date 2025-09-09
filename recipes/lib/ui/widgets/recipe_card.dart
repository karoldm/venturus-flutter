import 'package:recipes/data/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/di/service_locator.dart';
import 'package:recipes/ui/recipes/recipes_viewmodel.dart';

class RecipeCard extends StatelessWidget {
  final viewModel = getIt<RecipesViewModel>();
  final Recipe recipe;

  RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final isFavorite = viewModel.favRecipes.any((fav) => fav.id == recipe.id);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                recipe.image!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                    ? child
                    : Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                errorBuilder: (context, child, stackTrace) => Container(
                  height: 200,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.error),
                ),
              ),
            ),
            ListTile(
              titleTextStyle: GoogleFonts.rubik(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(recipe.name, textAlign: TextAlign.start),
              ),
              subtitleTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              subtitle: Text('${recipe.cuisine}', textAlign: TextAlign.start),
              trailing: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 32,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  if (isFavorite) {
                    viewModel.toggleFavorite(recipe);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${recipe.name} desfavoritada!'),
                          duration: Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'DESFAZER',
                            onPressed: () {
                              viewModel.toggleFavorite(recipe);
                            },
                          ),
                        ),
                      );
                    }
                  } else {
                    viewModel.toggleFavorite(recipe);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${recipe.name} favoritada!'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.help_outline_sharp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      '${recipe.difficulty}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      '${recipe.prepTimeMinutes} min',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.people_alt_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      '${recipe.servings}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.local_fire_department_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      '${recipe.caloriesPerServing} cal',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.star_border_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      '${recipe.rating?.toStringAsFixed(1) ?? 'N/A'} (${recipe.reviewCount ?? 0})',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
