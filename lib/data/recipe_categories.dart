class RecipeCategory {
  final String id;
  final String name;
  final String iconUrl; // or use IconData if using Flutter icons
  final String description;

  RecipeCategory({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.description,
  });
}

final List<RecipeCategory> recipeCategories = [
  RecipeCategory(
    id: 'c01',
    name: 'Main Course',
    iconUrl: 'https://img.icons8.com/color/96/steak.png',
    description: 'Hearty meals like pasta, rice dishes, and proteins.',
  ),
  RecipeCategory(
    id: 'c02',
    name: 'Breakfast',
    iconUrl: 'https://img.icons8.com/color/96/breakfast.png',
    description: 'Start your day with healthy and energizing meals.',
  ),
  RecipeCategory(
    id: 'c03',
    name: 'Dessert',
    iconUrl: 'https://img.icons8.com/color/96/cake.png',
    description: 'Sweet treats like cakes, cookies, and puddings.',
  ),
  RecipeCategory(
    id: 'c04',
    name: 'Beverage',
    iconUrl: 'https://img.icons8.com/color/96/smoothie.png',
    description: 'Drinks including smoothies, juices, and cocktails.',
  ),
  RecipeCategory(
    id: 'c05',
    name: 'Salad',
    iconUrl: 'https://img.icons8.com/color/96/salad.png',
    description: 'Fresh vegetable and fruit-based dishes.',
  ),
  RecipeCategory(
    id: 'c06',
    name: 'Snack',
    iconUrl: 'https://img.icons8.com/color/96/french-fries.png',
    description: 'Quick and light eats for any time of the day.',
  ),
  RecipeCategory(
    id: 'c07',
    name: 'Soup',
    iconUrl: 'https://img.icons8.com/color/96/soup.png',
    description: 'Warm and comforting bowls of soup and broth.',
  ),
  RecipeCategory(
    id: 'c08',
    name: 'Appetizer',
    iconUrl: 'https://img.icons8.com/color/96/starter.png',
    description: 'Small dishes served before the main meal.',
  ),
  RecipeCategory(
    id: 'c09',
    name: 'Vegan',
    iconUrl: 'https://img.icons8.com/color/96/vegan-food.png',
    description: 'Plant-based recipes with no animal products.',
  ),
  RecipeCategory(
    id: 'c10',
    name: 'Gluten-Free',
    iconUrl: 'https://img.icons8.com/color/96/no-gluten.png',
    description: 'Recipes made without wheat or gluten ingredients.',
  ),
];
