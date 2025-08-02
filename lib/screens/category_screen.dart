import 'package:flutter/material.dart';
import 'package:recipe_book_app/data/sample_recipes.dart';
import 'package:recipe_book_app/utils/responsive_breakpoints.dart';
import 'package:recipe_book_app/widgets/recipe/recipe_grid.dart';
import 'package:recipe_book_app/widgets/recipe/recipe_list.dart';

import '../models/recipe.dart';

class CategoryScreen extends StatefulWidget {
  final bool isGridView; // condition to change
  final String category;
  const CategoryScreen({
    Key? key,
    required this.category,
    this.isGridView = true,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isGridView = true; // condition to change
  @override
  Widget build(BuildContext context) {
    //Filter recipes by category
    final filteredCategory = SampleRecipes.sampleRecipes
        .where((recipe) => recipe.category == widget.category)
        .toList();

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isGridView
                ? _buildGridViewRecipes(context)
                : _buildListViewRecipes(
                    context, filteredCategory.length, filteredCategory),
          ],
        ),
      ),
    );
  }

//Appbar class
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(title: Text('${widget.category} Recipe'), actions: [
      IconButton(
          icon: Icon(isGridView ? Icons.list : Icons.grid_view),
          onPressed: () => setState(() {
                isGridView = !isGridView;
              }))
    ]);
  }

  //List View
  Widget _buildListViewRecipes(
      BuildContext context, int itemCount, List<Recipe> filteredCategory) {
    return SizedBox(
      height: 1200,
      child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return RecipeList(
              recipes: filteredCategory,
              maxItems: ResponsiveBreakpoints.isMobile(context) ? 4 : 10,
              recipe: filteredCategory[index],
              onTap: () => _navigateToDetail(context),
            );
          }),
    );
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

  void _navigateToDetail(BuildContext context) {
    Navigator.pushNamed(context, 'recipe-detail');
  }
}
