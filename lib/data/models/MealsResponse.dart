import 'Meal.dart';

class MealsResponse {
  final List<Meal> meals;

  MealsResponse({
    required this.meals,
  });

  factory MealsResponse.fromJson(Map<String, dynamic> json) {
    return MealsResponse(
      meals: (json['meals'] as List)
          .map((mealJson) => Meal.fromJson(mealJson))
          .toList(),
    );
  }
}
