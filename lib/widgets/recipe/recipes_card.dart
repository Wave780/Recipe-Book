import 'package:flutter/material.dart';

import '../../models/recipe.dart';

class ResponsiveRecipesCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;
  final VoidCallback? onFavourite;
  final bool isFavourite;

  const ResponsiveRecipesCard({
    super.key,
    required this.recipe,
    required this.onTap,
    required this.onFavourite,
    required this.isFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1200) {
        return _buildWideCard(context);
      } else {
        return _buildCompactCard(context);
      }
    });
  }

  //Wide card
  Widget _buildWideCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(context, height: 500),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildContent(context),
            )
          ],
        ),
      ),
    );
  }

//Image frame
  Widget _buildImage(BuildContext context, {required double height}) {
    return Stack(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            image: DecorationImage(
              image: NetworkImage(recipe.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: _buildFavouriteButton(),
        ),
        Positioned(
          top: 8,
          bottom: 8,
          child: _buildDifficultlyBadge(),
        ),
      ],
    );
  }

//Favourite Button
  Widget _buildFavouriteButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onFavourite,
        constraints: const BoxConstraints(maxWidth: 45, minHeight: 40),
        icon: Icon(
          isFavourite ? Icons.favorite : Icons.favorite_border,
          color: isFavourite ? Colors.red : Colors.grey[600],
        ),
      ),
    );
  }

//Badge(Easy, Medium & Hard)
  Widget _buildDifficultlyBadge() {
    Color badgeColor;
    switch (recipe.difficulty.toLowerCase()) {
      case 'easy':
        badgeColor = Colors.green;
        break;
      case 'medium':
        badgeColor = Colors.orange;
        break;
      case 'hard':
        badgeColor = Colors.red;
        break;
      default:
        badgeColor = Colors.grey;
    }
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        recipe.difficulty.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //Info Chip
  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  //Rating
  Widget _buildRating() {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 16,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          recipe.ratings.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ],
    );
  }

// Content Section
  Widget _buildContent(BuildContext context, {bool isCompact = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (isCompact) ...[
          const SizedBox(
            height: 2,
          ),
          Text(
            recipe.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            _buildInfoChip(
              icon: Icons.timer,
              label: '${recipe.totalTimeMethod} min',
              color: Colors.blue,
            ),
            const SizedBox(
              width: 8,
            ),
            _buildInfoChip(
              icon: Icons.people,
              label: '${recipe.servings}',
              color: Colors.green,
            ),
            const Spacer(),
            _buildRating(),
          ],
        )
      ],
    );
  }

  // Compact Card
  Widget _buildCompactCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImage(context, height: 150),
              Padding(
                padding: const EdgeInsets.all(12),
                child: _buildContent(context, isCompact: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
