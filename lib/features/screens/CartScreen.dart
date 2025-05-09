import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/CartState.dart';
import '../blocs/CartCubit.dart';
import '../widgets/CartItemWidget.dart';
import '../widgets/SummaryRow.dart';
import 'HomeScreen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
              Spacer(),
              Text("Cart", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Spacer(),
              SizedBox(width: 24),
            ],
          ),
          SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.error != null) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state.orders.isEmpty) {
                  return Center(child: Text('No items in the cart.'));
                } else {
                  return ListView.builder(
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      final order = state.orders[index];
                      return CartItemWidget(
                        image: order['image_path'],
                        name: order['item_name'],
                        category: order['item_category'],
                        quantity: order['quantity'],
                        onDelete: () {
                          context.read<CartCubit>().deleteOrder(order['id']);
                        },
                      );
                    },
                  );
                }
              },
            ),
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
                  child: Text("Add", style: TextStyle(color: Colors.white, fontSize: 16)),
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
                Text("Delivery Address", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                SizedBox(height: 8),
                Text("Avinguda Meridiana, 350, 358, 08027\nBarcelona", style: TextStyle(color: Colors.white70, fontSize: 14)),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("Total ", style: TextStyle(color: Colors.white70, fontSize: 16)),
                    Text("\$17.30", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        child: Text("Go to checkout", style: TextStyle(color: Colors.white, fontSize: 16)),
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
