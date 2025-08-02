import 'package:flutter/material.dart';
import 'package:recipe_book_app/data/sample_recipes.dart';
import 'package:recipe_book_app/utils/responsive_breakpoints.dart';

import '../models/recipe.dart';
import '../widgets/recipe/recipe_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  String searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> allRecipes = SampleRecipes.sampleRecipes;
  List<Recipe> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    filteredRecipes = allRecipes;
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _showSearch('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            const SizedBox(
              height: 32,
            ),
            _buildQuickCategories(context),
            const SizedBox(
              height: 32,
            ),
            _buildFeaturedRecipes(context),
          ],
        ),
      ),
    );
  }

//Appbar class
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              decoration: const InputDecoration(
                  hintText: "Search ... ", border: InputBorder.none),
              style: const TextStyle(color: Colors.black, fontSize: 18),
              onChanged: _showSearch,
            )
          : Text('Recipe Book'),
      actions: [
        IconButton(
            onPressed: () => _navigateToShoppingList(context),
            icon: const Icon(
              Icons.shopping_cart_rounded,
            )),
        IconButton(
            onPressed: () => _toggleSearch(),
            icon: Icon(_isSearching ? Icons.close : Icons.search))
      ],
    );
  }

//Hero section
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: ResponsiveBreakpoints.isMobile(context) ? 400 : 300,
      width: ResponsiveBreakpoints.isDesktop(context) ? 1200 : 1200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange[400]!, Colors.deepOrange[600]!],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Recipe Book',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Discover amazing recipes for every occassion',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () => _exploreRecipes,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange[600],
              ),
              child: const Text('Explore Recipes'),
            ),
          ],
        ),
      ),
    );
  }

//Quick categories
  Widget _buildQuickCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick categories',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _quickCategoryChip("Main Course",
                () => _navigateToCategory(context, "Main Course")),
            const SizedBox(
              width: 8,
            ),
            _quickCategoryChip(
                "Breakfast", () => _navigateToCategory(context, 'Breakfast')),
            const SizedBox(
              width: 8,
            ),
            _quickCategoryChip(
                "Dessert", () => _navigateToCategory(context, 'Dessert')),
          ],
        ),
      ],
    );
  }

//Chip widget for the category
  Widget _quickCategoryChip(String label, VoidCallback onPressed) {
    return ActionChip(
      label: Text(label),
      onPressed: onPressed,
    );
  }

//Featured Recipes
  Widget _buildFeaturedRecipes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Recipes',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => _viewAllRecipes(context),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        //Recipe Grid
        SizedBox(
          height: 1200,
          child: RecipeGrid(
            recipes:
                _isSearching ? filteredRecipes : SampleRecipes.sampleRecipes,
            maxItems: ResponsiveBreakpoints.isMobile(context)
                ? 4
                : 10, // Adjust this as needed
          ),
        ),
      ],
    );
  }

//Helper method
  void _navigateToCategory(BuildContext context, String category) {
    print('Navigating with category: Main Course');
    Navigator.pushNamed(context, 'category-screen', arguments: {
      'category': category,
    });
    //print("On press");
  }

  void _showSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredRecipes = allRecipes
          .where((recipe) =>
              recipe.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToShoppingList(BuildContext context) {}

  void _exploreRecipes(BuildContext context) {}

  void _viewAllRecipes(BuildContext context) {
    Navigator.pushNamed(context, 'recipe');
  }
}
