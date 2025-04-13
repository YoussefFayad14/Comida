import 'package:flutter/material.dart';
import '../../data/local/DatabaseHelper.dart';
import '../widgets/CartItemWidget.dart';
import '../widgets/SummaryRow.dart';
import 'HomeScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<Map<String, dynamic>>> orders;

  @override
  void initState() {
    super.initState();
    orders = DatabaseHelper().getAllOrders();
  }

  void removeOrder(int id, int index) async {
    await DatabaseHelper().deleteOrder(id);
    setState(() {
      orders = DatabaseHelper().getAllOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 56),
          Row(
            children: [
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
              Spacer(),
              Text(
                "Cart",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              SizedBox(width: 24),
            ],
          ),
          SizedBox(height: 24),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: orders,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No items in the cart.'));
              } else {
                List<Map<String, dynamic>> orders = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        image: orders[index]['image_path'],
                        name: orders[index]['item_name'],
                        category: orders[index]['item_category'],
                        quantity: orders[index]['quantity'],
                        onDelete: () {
                          removeOrder(orders[index]['id'], index);
                        },

                      );
                    },
                  ),
                );
              }
            },
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Promo Code",
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  print("Add button pressed");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          SummaryRow(title: "Subtotal", value: "\$12.20"),
          SummaryRow(title: "Tax and Fees", value: "\$4.10"),
          SummaryRow(title: "Delivery", value: "\$1.00"),
          Spacer(),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF1E1E2C),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Avinguda Meridiana, 350, 358, 08027\nBarcelona",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Total ",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Text(
                      "\$17.30",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        child: Text(
                          "Go to checkout",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
