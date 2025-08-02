import 'dart:core';

import 'ingredient.dart';
import 'nutritioninfo.dart';

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> additionalImage;
  final int cookTimeMinutes;
  final int prepTimeMinutes;
  final int servings;
  final String difficulty; //easy, medium, hard
  final List<Ingredient> ingredient;
  final List<String> instruction;
  final List<String> tags;
  final NutritionInfo nutritionInfo;
  final double ratings;
  final int reviewCount;
  final String category;
  final DateTime createdAt;

  Recipe(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      this.additionalImage = const [],
      required this.cookTimeMinutes,
      required this.prepTimeMinutes,
      required this.servings,
      required this.difficulty,
      required this.ingredient,
      required this.instruction,
      this.tags = const [],
      required this.nutritionInfo,
      this.ratings = 0.0,
      this.reviewCount = 0,
      required this.category,
      required this.createdAt});

  //Helper method
  int get totalTimeMethod => cookTimeMinutes + prepTimeMinutes;

  bool get isQuickMeal => totalTimeMethod <= 30;

  bool get isVegetarian => tags.contains('vegetarian');

  bool get isVegan => tags.contains('vegan');

  bool get isGlutenFree => tags.contains('gluten-free');

  //Method to scale ingredients for different serving sizes
  Recipe scaleForServing(int newServings) {
    final scaleFactor = newServings / servings;
    final scaledIngredients =
        ingredient.map((ingredient) => ingredient.scale(scaleFactor)).toList();
    return Recipe(
        id: id,
        title: title,
        description: description,
        imageUrl: imageUrl,
        cookTimeMinutes: cookTimeMinutes,
        prepTimeMinutes: prepTimeMinutes,
        servings: servings,
        difficulty: difficulty,
        ingredient: ingredient,
        instruction: instruction,
        nutritionInfo: nutritionInfo,
        category: category,
        createdAt: createdAt);
  }
}
