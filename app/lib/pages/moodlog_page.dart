import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodLogPage extends StatefulWidget {
  const MoodLogPage ({super.key});

  @override
  _MoodLogPageState createState() => _MoodLogPageState();
}

class _MoodLogPageState extends State<MoodLogPage> {
  final TextEditingController _moodController = TextEditingController();
  final TextEditingController _diaryController = TextEditingController();

  int selectedColor = 0;
  List<int> colorOptions = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<Color> colors = [Color(0xFFFFF34D), Color(0xFFDC1B14), Color(0xFF7FD9F9), Color(0xFF9BDE5B),
  Color(0xFFD8B7F1), Color(0xFFEC640D), Color(0xFF71749C), Color(0xFFF98DBD), Color(0xFF6DD8D2)];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: Stack (
        children: [
          _buildBackground(),
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.05,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacementNamed(context, "/mood"),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                width: isLandscape ? screenWidth * 0.6 : screenWidth * 1.05,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "🌈 How Are You Feeling Today?",
                      style: GoogleFonts.istokWeb(
                              fontSize: isLandscape ? screenWidth * 0.03 : screenWidth * 0.059,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFE1B9),
                            ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: Color(0xFFDEFFFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xFFFF9F1C),
                          width: 3,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: List.generate(colorOptions.length, (i) {
                              return _buildRadioOption(colorOptions[i], colors[i], screenWidth, screenHeight, isLandscape);
                            }),
                          ),
                          SizedBox(height: 10),
                          _buildInputSection("Type your mood here...", _moodController, 0.05, screenHeight, screenWidth, isLandscape, 1),
                          SizedBox(height: 10),
                          _buildInputSection("Write about your day...", _diaryController, 0.4, screenHeight, screenWidth, isLandscape, 10),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  int selectedDay = DateTime.now().day; // Get today's day
                                  userDiaryEntries[selectedDay] = _diaryController.text; // Save entry
                                });
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                      title: Text("🎉 Mood saved! "),
                                      content: Text("Hope today was a great day! 😊"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pushReplacementNamed(context, "/mood");
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFF9F1C),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                ),
                              child: Text(
                                "Save Mood",
                                style:GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.04,
                                ),
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
          _buildSquare(left: screenWidth * 0.85, top: screenHeight * 0.15, size: screenWidth * 0.12, color: Color(0xFF46E5D0), rotation: 10),
          _buildSquare(left: screenWidth * 0.1, top: screenHeight * 0.3, size: screenWidth * 0.1, color: Color(0xFF46E5D0), rotation: 0),
          _buildSquare(left: screenWidth * 0.8, top: screenHeight * 0.5, size: screenWidth * 0.1, color: Color(0xFF46E5D0), rotation: 0),
          _buildSquare(left: screenWidth * 0.05, top: screenHeight * 0.95, size: screenWidth * 0.08, color: Color(0xFF46E5D0), rotation: 0),
        ],
      ),
    );
  }

  // Helper method to create circles dynamically
  Widget _buildSquare({required double left, required double top, required double size, required Color color, required double rotation}) {
    return Positioned(
      left: left,
      top: top,
      child: Transform.rotate(
        angle: rotation * 3.1416 / 180,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection(String hintText, TextEditingController controller, double heightProportion, double screenHeight, double screenWidth, bool isLandscape, int line) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: screenHeight * heightProportion,
          child: TextField(
            controller: controller,
            minLines: line,
            maxLines: line,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.mukta(
                color: Color(0xFF49454F),
                fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.04,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            ),
          ),
        ),
      ],
    );
  }




  Widget _buildRadioOption(int option, Color color, double screenWidth, double screenHeight, bool isLandscape) {
    bool isSelected = selectedColor == option;
    
    return Radio(
          value: option,
          groupValue: selectedColor,
          onChanged: (value) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
              selectedColor = value!;
              });
            });
          },
          activeColor: color,
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return color.withOpacity(0.8);
            }
            return color.withOpacity(0.5);
          }),
        );
  }
}