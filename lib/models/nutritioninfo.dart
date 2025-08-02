class NutritionInfo {
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fibre;
  final double sugar;
  final double sodium;

  NutritionInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fibre,
    required this.sugar,
    required this.sodium,
  });

  NutritionInfo scale(double factor) {
    return NutritionInfo(
      calories: (calories * factor).round(),
      protein: protein * factor,
      carbs: carbs * factor,
      fat: fat * factor,
      fibre: fibre * factor,
      sugar: sugar * factor,
      sodium: sodium * factor,
    );
  }
}
