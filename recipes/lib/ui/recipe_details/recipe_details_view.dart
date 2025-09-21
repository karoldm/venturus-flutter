import 'package:recipes/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/l10n/app_localizations.dart';
import 'package:recipes/ui/recipe_details/recipe_details_viewmodel.dart';
import 'package:recipes/ui/widgets/recipe_row_details.dart';

class RecipeDetailsView extends StatefulWidget {
  const RecipeDetailsView({super.key, required this.id});

  final String id;

  @override
  State<RecipeDetailsView> createState() => _RecipeDetailsViewState();
}

class _RecipeDetailsViewState extends State<RecipeDetailsView>
    with SingleTickerProviderStateMixin {
  final viewModel = getIt<RecipeDetailViewModel>();

  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
          ..addStatusListener((listener) {
            if (listener == AnimationStatus.completed) {
              _animationController.reverse();
            }
          });

    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (!_initialized) {
      _initialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.loadRecipe(widget.id, l10n);
      });
    }

    return Obx(() {
      if (viewModel.isLoading) {
        return Center(
          child: SizedBox(
            height: 96,
            width: 96,
            child: CircularProgressIndicator(strokeWidth: 12),
          ),
        );
      }

      if (viewModel.errorMessage! != '') {
        return Center(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              spacing: 32,
              children: [
                Text(
                  'Erro: ${viewModel.errorMessage}',
                  style: TextStyle(fontSize: 24),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: Text(l10n.back),
                ),
              ],
            ),
          ),
        );
      }

      final recipe = viewModel.recipe;
      return Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  recipe?.image! ?? '',
                  height: 400,
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
                    height: 400,
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.primary,
                    child: Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        recipe?.name ?? '',
                        style: GoogleFonts.rubik(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      recipe != null
                          ? RecipeRowDetails(recipe: recipe)
                          : Container(),
                      const SizedBox(height: 16),
                      recipe?.ingredients.isNotEmpty ?? false
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "${l10n.ingredients}:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(recipe?.ingredients.join('\n') ?? ''),
                              ],
                            )
                          : Text(l10n.noIngredients),
                      const SizedBox(height: 16),
                      recipe?.instructions.isNotEmpty ?? false
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  '${l10n.instructions}:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(recipe?.instructions.join('\n') ?? ''),
                              ],
                            )
                          : Text(l10n.noInstructions),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => context.go('/'),
                            icon: Icon(Icons.arrow_back),
                            label: Text(l10n.back),
                          ),
                          const SizedBox(width: 16),
                          Obx(() {
                            // animatedSwitcher é um widget que anima a transição entre widgets
                            // quando o widget é reconstruído, ele anima a transição
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                // ScaleTransition é um built-in widget do Flutter
                                // que aplica uma escala ao widget durante a animação
                                // diminui e aumenta o widget
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: IconButton(
                                // key define o quando o widget deve ser reconstruído
                                // nesse caso quando o isFavorite mudar
                                key: ValueKey(viewModel.isFavorite),
                                onPressed: () {
                                  viewModel.toggleFavorite(l10n);
                                  _animationController.forward();
                                },
                                icon: Icon(
                                  viewModel.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Center(
              child: FadeTransition(
                opacity: _animation,
                child: ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0).animate(_animation),
                  child: Obx(() {
                    return Icon(
                      viewModel.isFavorite
                          ? Icons.favorite
                          : Icons.heart_broken,
                      color: viewModel.isFavorite ? Colors.red : Colors.grey,
                      size: 300,
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
