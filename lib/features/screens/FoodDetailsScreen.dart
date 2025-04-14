import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/FoodDetailsState.dart';
import '../../data/repo/FoodRepository.dart';
import '../blocs/FoodDetailsCubit.dart';
import '../widgets/BottomSheetItems.dart';
import '../widgets/FoodDetailsItemTag.dart';
import 'HomeScreen.dart';

class FoodDetailsScreen extends StatelessWidget {
  final String id;
  const FoodDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FoodDetailsCubit(id),
      child: Scaffold(
        body: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state.meal == null) {
              return const Center(child: Text('No meal data available'));
            } else {
              var mealData = state.meal!.meals[0];
              double totalPrice = state.itemCount * 100;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          color: Colors.orange,
                          onPressed: () {
                            var result = FoodRepository().addOrder(
                              mealData.strMeal ?? 'Meal Name',
                              mealData.strCategory ?? 'Category',
                              mealData.strMealThumb ?? 'Meal Image',
                              1,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result == -1
                                    ? "Error inserting order"
                                    : "Order inserted successfully"),
                                backgroundColor:
                                result == -1 ? Colors.red : Colors.green,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Center(
                      child: Hero(
                        tag: id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            mealData.strMealThumb ?? 'Meal Image',
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            mealData.strMeal ?? 'Meal Name',
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${mealData.strCategory}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        itemTag('Free delivery', 'assets/images/delivery_icon.png'),
                        const SizedBox(width: 16),
                        itemTag('45 mins', 'assets/images/clock_icon.png'),
                        const Spacer(),
                        Image.asset(
                          'assets/images/star_icon.png',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '4.5',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      mealData.strInstructions ??
                          'Description not available.',
                      style: const TextStyle(fontSize: 9, color: Colors.black87),
                    ),
                    const SizedBox(height: 24),
                    const Divider(height: 1, color: Colors.black12),
                    const SizedBox(height: 24),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.orange.withOpacity(0.1),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  color: Colors.white,
                                  onPressed: () {
                                    context
                                        .read<FoodDetailsCubit>()
                                        .decrementItem();
                                  },
                                ),
                                Text(
                                  '${state.itemCount}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  color: Colors.white,
                                  onPressed: () {
                                    context
                                        .read<FoodDetailsCubit>()
                                        .incrementItem();
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                padding:
                                const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                _showBottomSheet(context);
                              },
                              child: Text(
                                'Add ${state.itemCount} to basket  \$${totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF242731),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: const Color(0xFF242731),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Toppings for you',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                itemBottomSheet('Olives', true, "assets/images/itemOne.png"),
                itemBottomSheet('Cheese', false, "assets/images/itemTwo.png"),
                itemBottomSheet(
                    'Mushroom', false, "assets/images/itemThree.png"),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
