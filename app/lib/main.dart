import 'package:alt_f4/pages/home_page.dart';
import 'package:alt_f4/pages/login_page.dart';
import 'package:alt_f4/pages/food_page.dart';
import 'package:alt_f4/pages/profile_page.dart';
import 'package:alt_f4/pages/signup_page.dart';
import 'package:alt_f4/pages/settings_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras,));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({super.key, required this.cameras});

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
      initialRoute: "/profile",
      routes: {
        "/login": (context) => LoginPage(),
        "/signup": (context) => SignUpPage(),
        "/welcome": (context) => HomePage(),
        "/food": (context) => FoodPage(),
        "/profile": (context) => ProfilePage(),
        "/settings": (context) => SettingsPage(),
      },
    );
  }
}