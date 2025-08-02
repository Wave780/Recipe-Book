import 'package:flutter/material.dart';

import '../../models/recipe.dart';

class RecipeList extends StatelessWidget {
  final Recipe recipe;
  final List<Recipe> recipes;
  final int maxItems;
  final VoidCallback? onTap;
  const RecipeList({
    Key? key,
    required this.recipes,
    required this.maxItems,
    required this.recipe,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayedRecipes = recipes.take(maxItems).toList();
    return LayoutBuilder(builder: (context, constraints) {
      //Get the width this card has to work with
      final availableWidth = constraints.maxWidth;

      //Make layout decisions based on available space
      return _buildCardLayout(availableWidth);
    });
  }

  Widget _buildCardLayout(width) {
    //Decision time which layout should we use?

    if (width > 600) {
      //Lots of space side by side layout
      return _buildWideLayout(width);
    } else {
      // Limited space Stacked layout
      return _buildNarrowLayout(width, recipe);
    }
  }

  Widget _buildWideLayout(width) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 3,
        child: Row(
          children: [
            //Image section
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(recipe.imageUrl), fit: BoxFit.cover)),
            ),

            //Content section(takes the remaining space)
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Category badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      recipe.category.toUpperCase(),
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800]),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  //Title(Larger on wide screen)
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      fontSize: 18, // Bigger font for wide layout//
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  //Summary(more lines on wide screens)
                  Text(
                    recipe.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildNarrowLayout(
    width,
    Recipe recipe,
  ) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          //Image section
          Container(
            height: 180,
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                    image: NetworkImage(recipe.imageUrl), fit: BoxFit.cover)),
          ),

          //Content section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Title(Smaller on Mobile)
                Text(
                  recipe.title,
                  style: const TextStyle(
                    fontSize: 16, // Smaller font for wide layout//
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(
                  height: 8,
                ),

                //Summary(more lines on wide screens)
                Text(
                  recipe.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
