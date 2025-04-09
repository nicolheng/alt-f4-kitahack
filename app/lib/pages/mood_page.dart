import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MoodPage extends StatefulWidget {
  const MoodPage ({super.key});

  @override
  _MoodPageState createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  DateTime currentDate = DateTime.now();
  List<String> weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  List<Color> colors = [
    Color(0xFFFFF34D), Color(0xFFDC1B14), Color(0xFF7FD9F9),
    Color(0xFF9BDE5B), Color(0xFFD8B7F1), Color(0xFFEC640D),
    Color(0xFF71749C), Color(0xFFF98DBD), Color(0xFF6DD8D2)
  ];

  Map<DateTime, String> mockDiaryEntries = {
    DateTime(2025, 3, 31): "Had a great day today!",
    DateTime(2025, 4, 1): "Feeling a bit tired but productive.",
  };//example

  String _getDayOfWeek(DateTime date) {
    List<String> days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    return days[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    int firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1).weekday % 7;

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
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10, top: 40),
              child: Container(
                width: isLandscape ? screenWidth * 0.5 : screenWidth * 0.12,
                height: isLandscape ? screenHeight * 0.5 : screenHeight * 0.4,
                decoration: BoxDecoration(
                  color: Color(0xFF1B7D74),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.065,
            right: screenWidth * 0.05,
            child: AutoSizeText(
              "Friends",
              style: GoogleFonts.tiltWarp(
                fontSize: isLandscape ? screenWidth * 0.02 : screenWidth * 0.038,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          // Floating Avatars
          Positioned(
            top: screenHeight * 0.1, // Moves avatars upwards to overlap container
            right: screenWidth * 0.065,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileAvatar(true, 'asset/exercise/rachel.png', Color(0xFF2EC456), screenWidth, isLandscape, "/profile"),
                  _buildProfileAvatar(true, 'asset/exercise/pikachu.png', Color(0xFFC46F2E), screenWidth, isLandscape, "/profile"),
                  _buildProfileAvatar(false, 'asset/exercise/user.png', Color(0xFF454FC2), screenWidth, isLandscape, "/profile"),
                  _buildProfileAvatar(false, 'asset/exercise/user.png', Color(0xFFED523E), screenWidth, isLandscape, "/profile"),
                ],
              ),
          ),
          Positioned(
            top: screenHeight * 0.09,
            left: screenWidth * 0.065,
            child: AutoSizeText(
              "Mood Log 🪵",
              style: GoogleFonts.tiltWarp(
                fontSize: isLandscape ? screenWidth * 0.02 : screenWidth * 0.08,
                fontWeight: FontWeight.w500,
                color: Color(0xFF084B45),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.14, right: screenWidth * 0.15,),
              child: Container(
                width: isLandscape ? screenWidth * 0.6 : screenWidth * 1.1,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 16),
                child: Column(
                  children: [
                    Container(
                      width: isLandscape ? screenWidth * 0.5 : screenWidth * 1.1,
                      height: isLandscape ? screenHeight * 0.5 : screenHeight * 0.75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0,4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Month Navigation Bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () => setState(() {
                                  currentDate = DateTime(currentDate.year, currentDate.month - 1, 1);
                                }),
                              ),
                              AutoSizeText(
                                DateFormat.yMMMM().format(currentDate),
                                style: GoogleFonts.signika(fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () => setState(() {
                                  currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
                                }),
                              ),
                            ],
                          ),

                          // Weekday Labels
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                childAspectRatio: 1.2,
                              ),
                              itemCount: weekDays.length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: AutoSizeText(
                                    weekDays[index],
                                    style: GoogleFonts.signika(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                            ),
                          ),

                          // Calendar Grid
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            height: screenHeight * 0.6,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                mainAxisSpacing: 45,
                                crossAxisSpacing: 5,
                              ),
                              itemCount: daysInMonth + firstDayOfMonth,
                              itemBuilder: (context, index) {
                                if (index < firstDayOfMonth) {
                                  return SizedBox.shrink(); // Empty spaces before 1st of month
                                }
                                int day = index - firstDayOfMonth + 1;
                                Color cellColor =  Color(0xFFD9D9D9); //userSelectedColors[day] ?? Colors.blue[100]; read from database
                                return GestureDetector(
                                  onTap: () {
                                    DateTime selectedDate = DateTime(currentDate.year, currentDate.month, day);
                                    String diaryText = mockDiaryEntries[selectedDate] ?? "No entry recorded for this day.";

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("${_getDayOfWeek(selectedDate)}, $day/${currentDate.month}/${currentDate.year}"),
                                          content: Text(diaryText),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Close"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: cellColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      "$day",
                                      style: GoogleFonts.tiltNeon(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40, right: 30), //change
              child: Stack (
                clipBehavior: Clip.none,
                alignment: Alignment.bottomRight,
                children: [
                  ElevatedButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, "/moodlog");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF9F1C),
                          shape: CircleBorder(),
                          minimumSize: Size(70, 70),
                        ),
                        child: Image.asset(
                          'asset/mood/plusIcon.png',
                          width: isLandscape ? screenWidth * 0.04 : screenWidth * 0.11,
                          height: isLandscape ? screenWidth * 0.04 : screenWidth * 0.11,
                        ),
                      ),
                  Positioned(
                    top: -110, //change
                    right: -25,
                    child: Image.asset(
                      'asset/mood/panda.png',
                      width: isLandscape ? screenWidth * 0.06 : screenWidth * 0.35,
                      height: isLandscape ? screenWidth * 0.06 : screenWidth * 0.35,
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

  Widget _buildBackground() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF2EC4B6),
      ),
      child: Stack(
        children: [
          _buildSquare(left: screenWidth * 0.75, top: screenHeight * 0.08, size: screenWidth * 0.35, color: Color.fromARGB(194, 33, 121, 114), rotation: 20),
          _buildSquare(left: screenWidth * -0.05, top: screenHeight * 0.38, size: screenWidth * 0.52, color: Color.fromARGB(194, 33, 121, 114), rotation: -15),
          _buildSquare(left: screenWidth * 0.68, top: screenHeight * 0.55, size: screenWidth * 0.25, color: Color.fromARGB(194, 33, 121, 114), rotation: 10),
          _buildSquare(left: screenWidth * 0.35, top: screenHeight * 0.75, size: screenWidth * 1.2, color: Color.fromARGB(194, 33, 121, 114), rotation: -10),
          _buildSquare(left: screenWidth * 0.82, top: screenHeight * 0.15, size: screenWidth * 0.16, color: Color(0xFF46E5D0), rotation: -20),
          _buildSquare(left: screenWidth * 0.1, top: screenHeight * 0.3, size: screenWidth * 0.1, color: Color(0xFF46E5D0), rotation: 0),
          _buildSquare(left: screenWidth * 0.8, top: screenHeight * 0.5, size: screenWidth * 0.1, color: Color(0xFF46E5D0), rotation: 0),
          _buildSquare(left: screenWidth * 0.05, top: screenHeight * 0.95, size: screenWidth * 0.08, color: Color(0xFF46E5D0), rotation: 0),
        ],
      ),
    );
  }

  // Helper method to create circles dynamically
  Widget _buildSquare({required double left, required double top, required double size, required Color color, required double rotation}) {
    double safeSize = size > 0 ? size : 1.0;

    return Positioned(
      left: left,
      top: top,
      child: Transform.rotate(
        angle: rotation * 3.1416 / 180,
        child: Container(
          width: safeSize,
          height: safeSize,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(bool isOnline, String imagePath, Color borderColor, double screenWidth, bool isLandscape, String routeName) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              width: isLandscape ? screenWidth * 0.1 : screenWidth * 0.12, //circular
              height: isLandscape ? screenWidth * 0.1 : screenWidth * 0.12,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, routeName);
                },
                backgroundColor: borderColor,
                shape: CircleBorder(), //circular shape
                child: CircleAvatar(
                  radius: isLandscape ? screenWidth * 0.035 : screenWidth * 0.05,
                  backgroundImage: AssetImage(imagePath),
                  backgroundColor: Color(0xFFCBF3F0),
                ),
              ),
            ),
            SizedBox(height: 6),
          ],
        ),
        if (isOnline)
        Positioned(
          right: 2,
          bottom: 12,
          child: Container(
            width: isLandscape ? screenWidth * 0.015 : screenWidth * 0.03,
            height: isLandscape ? screenWidth * 0.015 : screenWidth * 0.03,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 75, 255, 81),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
