import 'package:flutter/material.dart';
import '../../data/models/MealsResponse.dart';
import '../../data/remote/ApiService.dart';
import 'HomeScreen.dart';

class FoodDetailsScreen extends StatefulWidget {
  final String id;

  const FoodDetailsScreen({super.key,required this.id});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int itemCount = 1;
  final double itemPrice = 100;
  late Future<MealsResponse> meal;


  @override
  void initState() {
    super.initState();
    meal = ApiService().getMealsById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MealsResponse>(
        future: meal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No meal data available'));
          } else {
            var mealData = snapshot.data!.meals[0];
            double totalPrice = itemCount * 100;
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
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen())
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_sharp),
                        color: Colors.orange,
                        onPressed: () {
                          print('Heart icon pressed');
                        },
                      ),
                    ],
                  ),
                  Center(
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
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          mealData.strMeal ?? 'Meal Name',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
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
                      _itemTag('Free delivery', 'assets/images/delivery_icon.png'),
                      const SizedBox(width: 16),
                      _itemTag('45 mins', 'assets/images/clock_icon.png'),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    mealData.strInstructions ?? 'Description not available.',
                    style: const TextStyle(
                      fontSize: 9,
                      color: Colors.black87,
                    ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                color: Colors.white,
                                onPressed: () {
                                  if (itemCount > 1) {
                                    setState(() {
                                      itemCount--;
                                    });
                                  }
                                },
                              ),
                              Text(
                                '$itemCount',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    itemCount++;
                                  });
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
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              _showBottomSheet();
                            },
                            child: Text(
                              'Add $itemCount to basket  \$${totalPrice.toStringAsFixed(2)}',
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
    );
  }

  Widget _itemTag(String text, String imagePath) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }


  Widget _itemBottomSheet(String text, bool isSelected, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white
            ),
          ),
          const Spacer(),
          isSelected
              ? Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: isSelected ? Colors.orange : Colors.grey,
            size: 24,
          )
              : Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked_outlined,
            color: isSelected ? Colors.orange : Colors.grey,
            size: 24,
          ),
        ],
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFF242731),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Color(0xFF242731),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Toppings for you',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _itemBottomSheet('Olives', true,"assets/images/itemOne.png"),
                _itemBottomSheet('Cheese', false,"assets/images/itemTwo.png"),
                _itemBottomSheet('Mushroom', false,"assets/images/itemThree.png"),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

}
