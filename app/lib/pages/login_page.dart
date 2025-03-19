import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: isLandscape ? screenWidth * 0.6 : screenWidth * 0.9,
              height: isLandscape ? screenHeight * 0.9 : screenHeight * 0.6,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Image.asset('asset/login/profileIcon.png',
                    width: screenWidth * 0.4,
                    height: screenWidth * 0.4,
                    fit: BoxFit.contain,
                    ),
                    SizedBox(height: screenHeight * 0.03),//Spacing
                    
                    //Green Container for Username & Password
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),//Padding inside the box
                      decoration: BoxDecoration(
                        color: Color(0xFF2EC4B6),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Username Field
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Username',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          // Password Field
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),

                          // Buttons Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, "/welcome");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFF9F1C),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                                ),
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: isLandscape ? screenWidth * 0.025 : screenWidth * 0.035, 
                                    fontWeight: isLandscape ? FontWeight.w500 : FontWeight.w400,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, "/signup");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFF9F1C),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                                ),
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: isLandscape ? screenWidth * 0.025 : screenWidth * 0.035, 
                                    fontWeight: isLandscape ? FontWeight.w500 : FontWeight.w400,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}