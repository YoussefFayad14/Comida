import 'models/MealsResponse.dart';

abstract class MealsState {}

class MealsInitial extends MealsState {}

class MealsLoading extends MealsState {}

class MealsLoaded extends MealsState {
  final MealsResponse meals;
  MealsLoaded(this.meals);
}

class MealsError extends MealsState {
  final String message;
  MealsError(this.message);
}
