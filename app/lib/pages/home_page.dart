import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const Color transparent = Color(0x00000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Stack(
      children: [
        _backgroundGradient(context),
        _buttons(context),
        Positioned(
          top: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // Navigation handled by StreamBuilder in main.dart
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _backgroundGradient(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(decoration: const BoxDecoration(color: Color(0x00000000))),
        Positioned(
          top: screenHeight * 0.3,
          left: screenWidth * -0.055,
          child: ClipOval(
            child: Container(
              width: 52,
              height: 52,
              color: const Color.fromARGB(90, 149, 228, 223),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * -0.1,
          right: screenWidth * -0.1,
          child: ClipOval(
            child: Container(
              width: 201,
              height: 201,
              color: const Color.fromARGB(70, 255, 191, 105),
            ),
          ),
        ),
        Positioned(
          bottom: screenHeight * -0.1,
          right: screenWidth * 0.25,
          child: ClipOval(
            child: Container(
              width: 192,
              height: 192,
              color: const Color.fromARGB(70, 46, 196, 182),
            ),
          ),
        ),
        Positioned(
          bottom: screenHeight * 0.23,
          right: screenWidth * -0.1,
          child: ClipOval(
            child: Container(
              width: 83,
              height: 83,
              color: const Color.fromARGB(90, 149, 228, 223),
            ),
          ),
        ),
        Positioned(
          bottom: screenHeight * -0.04,
          right: screenWidth * -0.1,
          child: ClipOval(
            child: Container(
              width: 245,
              height: 245,
              color: const Color.fromARGB(70, 255, 191, 105),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttons(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: transparent,
        body: Center(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.35, right: 20, left: 20),
                child: GridView.count(
                  shrinkWrap: false,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    CategoryButton(
                      title: "Exercise",
                      icon: Icons.directions_run,
                      bgColor: const Color(0x99FFBF69),
                      onPressed: () => Navigator.pushReplacementNamed(context, "/exercise"),
                      iconImg: "asset/homepage/footsteps.png",
                    ),
                    CategoryButton(
                      title: "Food",
                      icon: Icons.restaurant,
                      bgColor: const Color(0x99FB9100),
                      onPressed: () => Navigator.pushNamed(context, "/food"),
                      iconImg: "asset/homepage/recipe_book.png",
                    ),
                    CategoryButton(
                      title: "Profile",
                      icon: Icons.person,
                      bgColor: const Color(0x99BEF1ED),
                      onPressed: () => Navigator.pushNamed(context, "/profile"),
                      iconImg: "asset/homepage/resume.png",
                    ),
                    CategoryButton(
                      title: "Mood",
                      icon: Icons.emoji_emotions,
                      bgColor: const Color(0x992EC4B6),
                      onPressed: () => Navigator.pushReplacementNamed(context, "/mood"),
                      iconImg: "asset/homepage/fern.png",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.06, left: screenWidth * 0.1),
                child: ClipOval(
                  child: Container(
                    width: screenHeight * 0.25,
                    height: screenHeight * 0.25,
                    decoration: const BoxDecoration(
                      color: Colors.cyan,
                      image: DecorationImage(
                        image: AssetImage("asset/homepage/default_profile.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.09, left: screenWidth * 0.57),
                child: Text(
                  "Welcome Back,\n${FirebaseAuth.instance.currentUser?.displayName ?? 'Fellow User'}...",
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SettingButton(
                title: "Settings",
                bgColor: const Color(0x80C6F1FF),
                onPressed: () => Navigator.pushReplacementNamed(context, "/settings"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CategoryButton and SettingButton remain unchanged
class CategoryButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final VoidCallback onPressed;
  final String iconImg;

  const CategoryButton({
    super.key,
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.onPressed,
    required this.iconImg,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        padding: EdgeInsets.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                image: DecorationImage(image: AssetImage(iconImg), fit: BoxFit.cover),
              ),
              child: Align(
                alignment: const Alignment(-0.9, -0.85),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: Icon(
                      icon,
                      size: 30,
                      shadows: const [
                        Shadow(color: Colors.black12, blurRadius: 8.0, offset: Offset(0, 2.0)),
                        Shadow(color: Colors.white, blurRadius: 8.0, offset: Offset(0, 2.0)),
                      ],
                      color: bgColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final VoidCallback onPressed;

  const SettingButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0x00FFFFFF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            padding: EdgeInsets.zero,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              border: const Border(top: BorderSide(color: Colors.white, width: 3)),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}