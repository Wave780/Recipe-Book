import 'package:flutter/material.dart';
import 'package:recipe_book_app/screens/category_screen.dart';
import 'package:recipe_book_app/screens/favourite_screen.dart';
import 'package:recipe_book_app/screens/home_screen.dart';
import 'package:recipe_book_app/screens/profile_screen.dart';
import 'package:recipe_book_app/screens/recipe_detail_screen.dart';
import 'package:recipe_book_app/screens/recipes_list_screen.dart';

import '../models/recipe.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return _buildRoute(const HomeScreen(), setting);
      case 'recipe':
        return _buildRoute(const RecipesListScreen(), setting);
      case 'category-screen':
        print('Received arguments: ${setting.arguments}');

        if (setting.arguments is Map<String, dynamic>) {
          // ||setting.arguments is String
          //final category = setting.arguments as String;
          final args = setting.arguments as Map<String, dynamic>;
          final category = args['category'];
          if (category is String && category.isNotEmpty) {
            return _buildRoute(
              CategoryScreen(
                category: category,
              ),
              setting,
            );
          } else {
            return _buildErrorRoute('Recipe Category  is not found');
          }
        }
        // print("Navigating with category: ${setting.arguments}");
        return _buildErrorRoute('Recipe Category  is not found');
      case 'recipe-detail':
        //Check if we have required information
        if (setting.arguments is Map<String, dynamic>) {
          final args = setting.arguments as Map<String, dynamic>;

          if (args['recipe'] is Recipe) {
            final recipe = args['recipe'] as Recipe;

            return _buildRoute(
              RecipeDetailScreen(recipe: recipe),
              setting,
            );
          }
        }
        //If data is missing show this error
        return _buildErrorRoute('Recipe Data is required');
      case 'favourite':
        if (setting.arguments is Map<String, dynamic>) {
          final args = setting.arguments as Map<String, dynamic>;
          final List<Recipe> recipes = args['favourites'];

          return _buildRoute(
              FavouriteScreen(favouriteRecipes: recipes), setting);
        }
        return _buildErrorRoute('Favourite Recipe  is not found');
      case 'profile':
        return _buildRoute(const ProfileScreen(), setting);
        break;
      default:
        return _buildErrorRoute('Page not found :${setting.name}');
    }
  }

  static Route<dynamic> _buildRoute(Widget page, RouteSettings setting) {
    return MaterialPageRoute(
      builder: (context) => page,
      settings: setting,
    );
  }

  static Route<dynamic> _buildErrorRoute(String message) {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Opps! something went wrong',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      ),
                      child: const Text(
                        'Go Home',
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
