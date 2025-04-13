import 'package:flutter/material.dart';
import '../../data/models/CategoriesResponse.dart';
import '../../data/models/Category.dart';
import '../../data/models/MealsResponse.dart';
import '../../data/remote/ApiService.dart';
import '../widgets/DeliveryAddressWidget.dart';
import '../widgets/MainItemWidget.dart';
import '../widgets/OfferItemCardWidget.dart';
import '../widgets/RestaurantItemCardWidget.dart';
import '../widgets/SearchBarWidget.dart';
import '../widgets/SectionTitleRow.dart';
import 'FoodDetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int selectedIndex = -1;
  late Future<CategoriesResponse> categories;
  late Future<MealsResponse> meals;
  late String selectedMeal ;

  @override
  void initState() {
    super.initState();
    selectedMeal = 'Beef';
    categories = ApiService().getCategories();
    meals = ApiService().getMealsByCategory(selectedMeal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeliveryAddressWidget(
              address: '387 Merdina',
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Color(0xFFFE724D), Color(0xFFFFC529)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(
                "Good Afternoon!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 8),
            SearchBarWidget(
              controller: _searchController,
              onChanged: (value) {
                print("Searching for: $value");
              },
            ),
            SizedBox(height: 8),
            FutureBuilder<CategoriesResponse>(
              future: categories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.categories.isEmpty) {
                  return Center(child: Text('No categories found.'));
                } else {
                  return Column(
                    children: [
                      SectionTitleRow("Categories"),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.categories.length,
                          itemBuilder: (context, index) {
                            return MainItemWidget(
                              imagePath: snapshot.data!.categories[index].strCategoryThumb,
                              name: snapshot.data!.categories[index].strCategory,
                              isSelected: selectedIndex == index,
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  selectedMeal = snapshot.data!.categories[index].strCategory;
                                  meals = ApiService().getMealsByCategory(selectedMeal);
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 16),
            FutureBuilder<MealsResponse>(
              future: meals,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.meals.isEmpty) {
                  return Center(child: Text('No meals available.'));
                } else {
                  var mealsList = snapshot.data!.meals;
                  return Column(
                    children: [
                      SectionTitleRow("Special Offers"),
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: mealsList.length,
                          itemBuilder: (context, index) {
                            return OfferCardWidget(
                              imagePath: mealsList[index].strMealThumb,
                              rating: 4.5,
                              itemName: mealsList[index].strMeal ?? "Unnamed",
                              freeDelivery: false,
                              price: 100,
                              cardColor: Colors.redAccent,
                              heroTag: mealsList[index].idMeal,
                              onBuyPressed: () {
                                print("Buy pressed for ${mealsList[index].idMeal}");
                                Navigator.push(
                                context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodDetailsScreen(id: mealsList[index].idMeal)
                                  )
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 16),
            SectionTitleRow("Restaurants"),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return RestaurantItemCardWidget(
                    imagePath: "assets/images/food.png",
                    title: "Seafood maki sushi",
                    rating: 4.5,
                    isFavorite: false,
                    onFavoriteToggle: () {
                      print("Favorite toggled");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
