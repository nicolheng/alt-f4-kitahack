import 'package:alt_f4/pages/home_page.dart';
import 'package:alt_f4/pages/login_page.dart';
import 'package:alt_f4/pages/food_page.dart';
import 'package:alt_f4/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AltF4 Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(
          0xfff6f6f6,
        ),
        appBarTheme: const AppBarTheme(),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: "/food",
      routes: {
        "/login": (context) => LoginPage(),
        "/signup": (context) => SignUpPage(),
        "/welcome": (context) => HomePage(),
        "/food": (context) => FoodPage(),
      },
    );
  }
}