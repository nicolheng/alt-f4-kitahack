import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage ({super.key});

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  //Example
  int currentKcal = 900;
  int targetKcal = 1800;
  double progress = 900 / 1800;
  int streaks = 20;
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildBackground(),
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.05,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacementNamed(context, "/welcome"),
            ),
          ),
          Positioned(
            top: screenHeight * 0.05,
            right: screenWidth * 0.05,
            child: _buildProfileAvatar('', 'asset/exercise/user.png', Color(0xFF2EC4B6), screenWidth, isLandscape, "/profile"),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.19),
              child: Container(
                width: isLandscape ? screenWidth * 0.6 : screenWidth * 1.1,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 16),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Green Container
                        Container(
                          width: isLandscape ? screenWidth * 0.5 : screenWidth * 1.1,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(0xFF2EC4B6),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8), // Dynamic rounded top
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 7, bottom: 5),
                              child: Text(
                                "💪 Workout with Friends!",
                                style: GoogleFonts.tiltWarp(
                                  fontSize: isLandscape ? screenWidth * 0.02 : screenWidth * 0.055,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Floating Avatars
                        Positioned(
                          top: -screenHeight * 0.05, // Moves avatars upwards to overlap container
                          left: -screenWidth * 0.1,
                          right: 0,
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildProfileAvatar('Pikachu', 'asset/exercise/pikachu.png', Color(0xFFC46F2E), screenWidth, isLandscape, "/profile"),
                                _buildProfileAvatar('Rachel', 'asset/exercise/rachel.png', Color(0xFF2EC456), screenWidth, isLandscape, "/profile"),
                                _buildProfileAvatar('Tom', 'asset/exercise/user.png', Color(0xFF454FC2), screenWidth, isLandscape, "/profile"),
                                _buildProfileAvatar('Jerry', 'asset/exercise/user.png', Color(0xFFED523E), screenWidth, isLandscape, "/profile"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: isLandscape ? screenWidth * 0.5 : screenWidth * 1.1,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xFF2EC4B6),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 7, top: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daily Goal Progress",
                                style: GoogleFonts.signika(
                                  fontSize: isLandscape ? screenWidth * 0.02 : screenWidth * 0.07,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: screenWidth * 0.85,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFB9100),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                      ),
                                      child: Container(
                                        width: screenWidth * 0.85 * progress,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.8 * progress - 55, // Adjust position
                                    child: Text(
                                      "$currentKcal kcal",
                                      style: GoogleFonts.signika(fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                "${(progress * 100).toStringAsFixed(1)}% completed",
                                style: GoogleFonts.signika(
                                  fontSize: isLandscape ? screenWidth * 0.02 : screenWidth * 0.05,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "🎯Target : $targetKcal kcal",
                                style: GoogleFonts.signika(
                                  fontSize: isLandscape ? screenWidth * 0.02 : screenWidth * 0.05,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "$streaks❤️‍🔥",
                                  style: GoogleFonts.signika(
                                    fontSize: isLandscape ? screenWidth * 0.02 : screenWidth * 0.065,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "📊 Today’s Exercise Log",
                        style: GoogleFonts.signika(
                          fontSize: isLandscape ? screenWidth * 0.02 : screenWidth * 0.06,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Column(
                      children:[
                        _buildExerciseLog("🏃🏻‍♂️", "Running", 40, 500, screenWidth, isLandscape),
                        SizedBox(height: 8),
                        _buildExerciseLog("🚴🏻‍♀️", "Cycling", 30, 300, screenWidth, isLandscape),
                        SizedBox(height: 8),
                        _buildExerciseLog("🚶", "Walking", 30, 100, screenWidth, isLandscape),
                      ],
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, "/exerciselog");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFCBF3F0),
                          shape: CircleBorder(),
                          minimumSize: Size(70, 70),
                        ),
                        child: Text(
                          "+",
                          style: TextStyle(
                            fontSize: isLandscape ? screenWidth * 0.04 : screenWidth * 0.11,
                            fontWeight: FontWeight.bold,
                            ),
                        ),
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

  Widget _buildBackground() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFFFFBF69), // Main background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          _buildCircle(left: screenWidth * 0.45, top: screenHeight * 0.05, size: screenWidth * 0.55, color: Color(0xFFFFD6A5)),
          _buildCircle(left: screenWidth * -0.05, top: screenHeight * 0.38, size: screenWidth * 0.52, color: Color(0xFFFFD6A5)),
          _buildCircle(left: screenWidth * 0.68, top: screenHeight * 0.55, size: screenWidth * 0.25, color: Color.fromARGB(168, 255, 160, 28)),
          _buildCircle(left: screenWidth * 0.35, top: screenHeight * 0.75, size: screenWidth * 1.2, color: Color(0xFFFF9F1C)),
        ],
      ),
    );
  }

  // Helper method to create circles dynamically
  Widget _buildCircle({required double left, required double top, required double size, required Color color}) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: ShapeDecoration(
          color: color,
          shape: OvalBorder(),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(String name, String imagePath, Color borderColor, double screenWidth, bool isLandscape, String routeName) {
    return Column(
      children: [
        SizedBox(
          width: isLandscape ? screenWidth * 0.1 : screenWidth * 0.16, 
          height: isLandscape ? screenWidth * 0.1 : screenWidth * 0.16,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, routeName);
            },
            backgroundColor: borderColor,
            shape: CircleBorder(), // Ensures circular shape
            child: CircleAvatar(
              radius: isLandscape ? screenWidth * 0.035 : screenWidth * 0.072,
              backgroundImage: AssetImage(imagePath),
              backgroundColor: Color(0xFFCBF3F0),
            ),
          ),
        ),
        SizedBox(height: 5), // Adjust spacing between button and text
        Text(name, style: GoogleFonts.tiltNeon(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal)),
      ],
    );
  }

  Widget _buildExerciseLog(String icon, String activity, int duration, int kcal, double screenWidth, bool isLandscape) {
    return Container(
      width: isLandscape ? screenWidth * 0.5 : screenWidth * 1.1,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFF2EC4B6),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            icon,
            style: TextStyle(fontSize: isLandscape ? screenWidth * 0.04 : screenWidth * 0.07),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity,
                style: GoogleFonts.signika(
                  fontSize: isLandscape ? screenWidth * 0.02 : screenWidth * 0.05,
                  color: Colors.black,
                ),
              ),
              Text(
                "$duration min - $kcal kcal 🔥",
                style: GoogleFonts.signika(
                  fontSize: isLandscape ? screenWidth * 0.015 : screenWidth * 0.04,
                  color: const Color.fromARGB(255, 79, 77, 77),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
