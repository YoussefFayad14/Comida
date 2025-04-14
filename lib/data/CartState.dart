
class CartState {
  final List<Map<String, dynamic>> orders;
  final bool isLoading;
  final String? error;

  CartState({this.orders = const [], this.isLoading = false, this.error});
}