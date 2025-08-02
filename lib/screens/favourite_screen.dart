import 'package:flutter/material.dart';
import 'package:recipe_book_app/utils/responsive_breakpoints.dart';
import 'package:recipe_book_app/widgets/recipe/recipe_grid.dart';

import '../models/recipe.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Recipe> favouriteRecipes;

  const FavouriteScreen({super.key, required this.favouriteRecipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: SizedBox(
        height: 1200,
        child: RecipeGrid(
          recipes: favouriteRecipes,
          maxItems: ResponsiveBreakpoints.isMobile(context)
              ? 4
              : 10, // Adjust this as needed
        ),
      ),
    );
  }
}
