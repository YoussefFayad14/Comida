import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/CategoryState.dart';
import '../../data/repo/FoodRepository.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FoodRepository repository;
  CategoryCubit(this.repository) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    try {
      emit(CategoryLoading());
      final categories = await repository.fetchCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
