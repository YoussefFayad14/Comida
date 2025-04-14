import 'package:comida_app/data/repo/FoodRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/CartState.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(isLoading: true)) {
    loadOrders();
  }

  void loadOrders() async {
    emit(CartState(isLoading: true));
    try {
      final orders = await FoodRepository().getAllOrders();
      emit(CartState(orders: orders, isLoading: false));
    } catch (e) {
      emit(CartState(isLoading: false, error: e.toString()));
    }
  }

  void deleteOrder(int id) async {
    await FoodRepository().deleteOrder(id);
    loadOrders();
  }
}