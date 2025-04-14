import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/MealsState.dart';
import '../../data/repo/FoodRepository.dart';

class MealsCubit extends Cubit<MealsState> {
  final FoodRepository repository;
  MealsCubit(this.repository) : super(MealsInitial());

  Future<void> fetchMealsByCategory(String category) async {
    try {
      emit(MealsLoading());
      final meals = await repository.fetchMealsByCategory(category);
      emit(MealsLoaded(meals));
    } catch (e) {
      emit(MealsError(e.toString()));
    }
  }

  Future<void> fetchMealById(String id) async {
    try {
      emit(MealsLoading());
      final meal = await repository.fetchMealById(id);
      emit(MealsLoaded(meal));
    } catch (e) {
      emit(MealsError(e.toString()));
    }
  }
}
