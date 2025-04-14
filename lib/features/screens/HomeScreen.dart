import 'package:comida_app/data/repo/FoodRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/CategoryState.dart';
import '../../data/MealsState.dart';
import '../../data/remote/ApiService.dart';
import '../blocs/CartCubit.dart';
import '../blocs/CategoryCubit.dart';
import '../blocs/MealsCubit.dart';
import '../widgets/DeliveryAddressWidget.dart';
import '../widgets/MainItemWidget.dart';
import '../widgets/OfferItemCardWidget.dart';
import '../widgets/RestaurantItemCardWidget.dart';
import '../widgets/SearchBarWidget.dart';
import '../widgets/SectionTitleRow.dart';
import 'CartScreen.dart';
import 'FoodDetailsScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text(
                textAlign: TextAlign.center,
                'Menu Drawer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                textAlign: TextAlign.center,
                'Your Cart',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              leading: const Icon(Icons.shopping_cart),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => CartCubit(),
                      child: CartScreen(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CategoryCubit(FoodRepository())..fetchCategories(),
          ),
          BlocProvider(
            create: (context) => MealsCubit(FoodRepository()),
          ),
        ],
        child: Builder(
          builder: (scaffoldContext) => SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DeliveryAddressWidget(
                  address: '387 Merdina',
                  onMenuTap: () {
                    Scaffold.of(scaffoldContext).openDrawer();
                  },
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
                  controller: TextEditingController(),
                  onChanged: (value) {
                    print("Searching for: $value");
                  },
                ),
                SizedBox(height: 8),
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CategoryError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else if (state is CategoryLoaded) {
                      return Column(
                        children: [
                          SectionTitleRow("Categories"),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.categories.categories.length,
                              itemBuilder: (context, index) {
                                return MainItemWidget(
                                  imagePath: state.categories.categories[index].strCategoryThumb,
                                  name: state.categories.categories[index].strCategory,
                                  isSelected: false,
                                  onTap: () {
                                    context.read<MealsCubit>().fetchMealsByCategory(state.categories.categories[index].strCategory);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(height: 16),
                BlocBuilder<MealsCubit, MealsState>(
                  builder: (context, state) {
                    if (state is MealsLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is MealsError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else if (state is MealsLoaded) {
                      return Column(
                        children: [
                          SectionTitleRow("Special Offers"),
                          SizedBox(
                            height: 170,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.meals.meals.length,
                              itemBuilder: (context, index) {
                                return OfferCardWidget(
                                  imagePath: state.meals.meals[index].strMealThumb,
                                  rating: 4.5,
                                  itemName: state.meals.meals[index].strMeal ?? "Unnamed",
                                  freeDelivery: false,
                                  price: 100,
                                  cardColor: Colors.redAccent,
                                  heroTag: state.meals.meals[index].idMeal,
                                  onBuyPressed: () {
                                    print("Buy pressed for ${state.meals.meals[index].idMeal}");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FoodDetailsScreen(id: state.meals.meals[index].idMeal)),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
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
        ),
      ),
    );
  }
}
