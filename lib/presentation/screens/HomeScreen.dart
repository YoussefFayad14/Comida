import 'package:flutter/material.dart';
import '../widgets/DeliveryAddressWidget.dart';
import '../widgets/MainItemWidget.dart';
import '../widgets/OfferItemCardWidget.dart';
import '../widgets/RestaurantItemCardWidget.dart';
import '../widgets/SearchBarWidget.dart';
import '../widgets/SectionTitleRow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:EdgeInsets.all(16.0),
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
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return MainItemWidget(
                    imagePath: "assets/images/burger.png",
                    name: 'burger $index',
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            SectionTitleRow("Special Offers"),
            SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return OfferCardWidget(
                    imagePath: "assets/images/burger.png",
                    rating: 4.5,
                    itemName: "Burger King",
                    freeDelivery: true,
                    price: 22.00,
                    cardColor: Colors.redAccent,
                    onBuyPressed: () {
                      print("Buy pressed for Burger King");
                    },
                  );
                },
              ),
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
