import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/MealsResponse.dart';
import '../../data/repo/FoodRepository.dart';

class FoodDetailsState {
  final int itemCount;
  final MealsResponse? meal;
  final bool isLoading;
  final String? error;

  FoodDetailsState({
    this.itemCount = 1,
    this.meal,
    this.isLoading = true,
    this.error,
  });

  FoodDetailsState copyWith({
    int? itemCount,
    MealsResponse? meal,
    bool? isLoading,
    String? error,
  }) {
    return FoodDetailsState(
      itemCount: itemCount ?? this.itemCount,
      meal: meal ?? this.meal,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

