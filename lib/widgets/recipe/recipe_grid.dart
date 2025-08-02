import 'package:flutter/material.dart';
import 'package:recipe_book_app/widgets/recipe/recipes_card.dart';

import '../../models/recipe.dart';

class RecipeGrid extends StatefulWidget {
  final List<Recipe> recipes;
  final int maxItems;
  RecipeGrid({
    super.key,
    required this.recipes,
    this.maxItems = 6,
  });

  @override
  State<RecipeGrid> createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
  final List<Recipe> favouriteRecipes = [];

  @override
  Widget build(BuildContext context) {
    final displayedRecipes = widget.recipes.take(widget.maxItems).toList();
    final isFavourite = favouriteRecipes.contains(displayedRecipes);
    return LayoutBuilder(builder: (context, constraints) {
      // Calculate how many columns based on available width
      final crossAxisCount = _calculateColunm(constraints.maxWidth);
      final spacing = _calculateSpacing(constraints.maxWidth);

      return GridView.builder(
          padding: EdgeInsets.all(spacing),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: 1.0, //Square photo
          ),
          itemCount: displayedRecipes.length,
          itemBuilder: (context, index) {
            return ResponsiveRecipesCard(
              recipe: displayedRecipes[index],
              isFavourite: isFavourite,
              onFavourite: () => _selectedFavourite(context),
              onTap: () => _navigateToDetail(context, displayedRecipes[index]),
            );
          });
    });
  }

  //Column calculation based on screen size
  int _calculateColunm(double width) {
    if (width > 1200) {
      return 6; //Desktop 5 per row
    } else if (width > 800) {
      return 4; //Tablet 4 per row
    } else if (width > 600) {
      return 2; // Small tablet 3 per row
    } else {
      return 1;
    }
  }

  //Spacing calculation
  double _calculateSpacing(double width) {
    //More spacing for larger screen
    if (width > 1200) {
      return 16.0; //Desktop spacing
    } else if (width > 800) {
      return 12.0; //Tablet spacing
    } else {
      return 8.0; //Mobile component spacing
    }
  }

  //Method to route selected Favourite
  void _selectedFavourite(BuildContext context) {
    print("Received ${favouriteRecipes.length} favourites");

    Navigator.pushNamed(
      context,
      '/favourite',
      arguments: {'favourites': favouriteRecipes},
    );
  }

  //Method
  void _toggleFavourite(Recipe recipe) {
    setState(() {
      if (favouriteRecipes.contains(recipe)) {
        favouriteRecipes.remove(recipe);
      } else {
        favouriteRecipes.add(recipe);
      }
      print("Toggled favourite: ${recipe.title}");
    });
  }

  //To Navigate to Recipe detail screen
  void _navigateToDetail(BuildContext context, Recipe recipe) {
    Navigator.pushNamed(context, 'recipe-detail',
        arguments: {'recipe': recipe});
  }
}
