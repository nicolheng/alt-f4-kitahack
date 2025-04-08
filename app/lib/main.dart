import 'package:alt_f4/pages/home_page.dart';
import 'package:alt_f4/pages/login_page.dart';
import 'package:alt_f4/pages/signup_page.dart';
import 'package:alt_f4/pages/food_page.dart';
import 'package:alt_f4/pages/food_history_page.dart';
import 'package:alt_f4/pages/camera_page.dart';
import 'package:alt_f4/pages/profile_page.dart';
import 'package:alt_f4/pages/settings_page.dart';
import 'package:alt_f4/pages/exercise_page.dart';
import 'package:alt_f4/pages/exerciselog_page.dart';
import 'package:camera/camera.dart';
import 'package:alt_f4/pages/mood_page.dart';
import 'package:alt_f4/pages/moodlog_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AltF4 Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(0xfff6f6f6),
        appBarTheme: const AppBarTheme(),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      // Replace static routes with StreamBuilder for auth state
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return const HomePage(); // Signed in
          }
          return const LoginPage(); // Signed out
        },
      ),
      routes: {
        "/login": (context) => const LoginPage(),
        "/signup": (context) => const SignUpPage(),
        "/welcome": (context) => const HomePage(),
        "/food": (context) => const FoodPage(),
        "/foodhistory": (context) => const FoodHistoryPage(),
        "/foodcamera": (context) => CameraPage(cameras: cameras),
        "/profile": (context) => const ProfilePage(),
        "/settings": (context) => const SettingsPage(),
        "/exercise": (context) => const ExercisePage(),
        "/exerciselog": (context) => const ExerciseLogPage(),
        "/mood": (context) => const MoodPage(),
        "/moodlog": (context) => const MoodLogPage(),
      },
    );
  }
}