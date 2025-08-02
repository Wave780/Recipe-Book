import 'package:flutter/material.dart';

import '../models/recipe.dart';

class NavigationHelper {
  // Safe navigation with data validation
  static void goToRecipeDetail({
    required BuildContext context,
    required Recipe recipe,
  }) {
    Navigator.pushNamed(
      context,
      '/recipe-detail',
      arguments: {
        'recipeId': recipe.id,
        'recipeName': recipe.title,
        'recipeData': recipe,
      },
    );
  }
}

// Usage
// NavigationHelper.goToRecipeDetail(
// context: context,
// recipe: selectedRecipe,
