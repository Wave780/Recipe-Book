import 'package:flutter/material.dart';

import '../data/sample_recipes.dart';
import '../utils/responsive_breakpoints.dart';
import '../widgets/recipe/recipe_grid.dart';
import '../widgets/recipe/recipe_list.dart';

class RecipesListScreen extends StatefulWidget {
  final bool isGridView; // condition to change
  const RecipesListScreen({
    super.key,
    this.isGridView = true,
  });

  @override
  State<RecipesListScreen> createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<RecipesListScreen> {
  bool isGridView = true; // condition to change
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isGridView
                ? _buildGridViewRecipes(context)
                : _buildListViewRecipes(context),
          ],
        ),
      ),
    );
  }

//Appbar class
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(title: const Text('Recipe'), actions: [
      IconButton(
          icon: Icon(isGridView ? Icons.list : Icons.grid_view),
          onPressed: () => setState(() {
                isGridView = !isGridView;
              }))
    ]);
  }

//Grid View Recipe
  Widget _buildGridViewRecipes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Recipe Grid
        SizedBox(
          height: 1200,
          child: RecipeGrid(
            recipes: SampleRecipes.sampleRecipes,
            maxItems: ResponsiveBreakpoints.isMobile(context)
                ? 4
                : 10, // Adjust this as needed
          ),
        ),
      ],
    );
  }

//ListView  Recipes
  Widget _buildListViewRecipes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Recipe Grid
        SizedBox(
          height: 1200,
          child: ListView.builder(
            itemCount: SampleRecipes.sampleRecipes.length,
            itemBuilder: (context, index) {
              return RecipeList(
                onTap: () => _navigateToDetail(context),
                recipes: SampleRecipes.sampleRecipes,
                maxItems: ResponsiveBreakpoints.isMobile(context) ? 4 : 10,
                recipe: SampleRecipes.sampleRecipes[index],
              );
            },
          ),
        ),
      ],
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.pushNamed(context, 'recipe-detail');
  }
}
