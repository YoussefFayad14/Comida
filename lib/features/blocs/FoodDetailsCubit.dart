import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/FoodDetailsState.dart';
import '../../data/repo/FoodRepository.dart';

class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  final String mealId;

  FoodDetailsCubit(this.mealId) : super(FoodDetailsState()) {
    fetchMeal();
  }

  void fetchMeal() async {
    try {
      emit(state.copyWith(isLoading: true));
      final meal = await FoodRepository().fetchMealById(mealId);
      emit(state.copyWith(meal: meal, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void incrementItem() {
    emit(state.copyWith(itemCount: state.itemCount + 1));
  }

  void decrementItem() {
    if (state.itemCount > 1) {
      emit(state.copyWith(itemCount: state.itemCount - 1));
    }
  }
}
