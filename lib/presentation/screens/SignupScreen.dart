import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../data/local/DatabaseHelper.dart';
import '../../util/SharedPreferencesHelper.dart';
import '../widgets/SocialButton.dart';
import 'HomeScreen.dart';
import 'LoginScreen.dart';
import 'OnboardingScreen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Image.asset(
                'assets/images/login_image.png',
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
          ),

          // Back button
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen()),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),

          // Login form container
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sign Up",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 8),
                  Text("Please enter your details to create account",
                      style: TextStyle(color: Colors.grey)),

                  SizedBox(height: 24),
                  Text("Full Name", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Ahmed Mohamed",
                      filled: true,
                      fillColor: Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "example@gmail.com",
                      filled: true,
                      fillColor: Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Password",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "••••••••••",
                      suffixIcon: Icon(Icons.visibility),
                      filled: true,
                      fillColor: Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF6B57),
                        padding: EdgeInsets.symmetric(
                            horizontal: 100, vertical: 16),
                        shape: StadiumBorder(),
                      ),
                      child:GestureDetector(
                        onTap: () async {
                          // Insert user to database
                          var result = await databaseHelper.insertUser(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                          if (result == -1) {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error inserting user"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }else {
                            // Show success message
                            // await SharedPreferencesHelper.setIsLog(true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("User inserted successfully"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Center(child: Text("Or Sign Up with")),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialButton("assets/images/facebook_icon.png", "FACEBOOK"),
                      SocialButton("assets/images/google_icon.png", "GOOGLE"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Log In",
                            style: TextStyle(color: Colors.red),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
