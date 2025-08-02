import 'package:flutter/material.dart';

import '../models/nutritioninfo.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  Recipe recipe;

  RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: _recipeDetail(context),
      ),
    );
  }

  //Appbar class
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Recipe Detail'),
    );
  }

  Map<String, String> buildNutritionMap(NutritionInfo nutrition) {
    return {
      'Calories': '${nutrition.calories} kcal',
      'Protein': '${nutrition.protein} g',
      'Fat': '${nutrition.fat} g',
      'Carbs': '${nutrition.carbs} g',
      'Fibre': '${nutrition.fibre} g',
      'Sugar': '${nutrition.sugar} g',
      'Sodium': '${nutrition.sodium} g',
    };
  }

  Widget _recipeDetail(BuildContext context) {
    final nutritionMap = buildNutritionMap(recipe.nutritionInfo);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Recipe image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            recipe.imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),

        //Title
        Text(
          recipe.title,
          style: const TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 24,
        ),
        // Description
        Text(
          recipe.description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),

        // Ingredients
        Text(
          'Ingredients',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        ...recipe.ingredient.map((ingredient) =>
            Text('• ${ingredient.quantity} ${ingredient.name}')),

        const SizedBox(height: 24),

        // Steps
        Text(
          'Steps',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        ...nutritionMap.entries
            .map((entry) => Text('• ${entry.key}: ${entry.value}'))
      ],
    );
  }
}
