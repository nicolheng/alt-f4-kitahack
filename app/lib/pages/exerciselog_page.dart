import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseLogPage extends StatefulWidget {
  const ExerciseLogPage ({super.key});

  @override
  _ExerciseLogPageState createState() => _ExerciseLogPageState();
}

class _ExerciseLogPageState extends State<ExerciseLogPage> {
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _speedController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  String? selectedActivity;
  List<String> activitySuggestions = ["Jogging", "Running", "Swimming", "Cycling", "Weightlifting", "Hiking", "Basketball", "Badminton"];
  List<String> filteredSuggestions = [];
  String? selectedIntensity = "Slow";

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
              onPressed: () => Navigator.pushReplacementNamed(context, "/exercise"),
            ),
          ),
          Center(
            child: Container(
              width: isLandscape ? screenWidth * 0.6 : screenWidth * 1.05,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 16),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text(
                      "Add Your Activity",
                      style: GoogleFonts.istokWeb(
                              fontSize: isLandscape ? screenWidth * 0.03 : screenWidth * 0.065,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xFF2EC4B6),
                          width: 3,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildActivitySelection(),
                          SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              text: "Speed ", // Main text
                              style: GoogleFonts.istokWeb(
                                color: Colors.black,
                                fontSize: isLandscape ? screenWidth * 0.025 : screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: "(optional)", // Smaller, lighter text
                                  style: GoogleFonts.istokWeb(
                                    color: Colors.grey, // Lighter color
                                    fontSize: isLandscape ? screenWidth * 0.018 : screenWidth * 0.04, // Smaller size
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildInputRow("mph", _speedController, screenWidth, screenHeight, isLandscape),
                          SizedBox(height: 10),
                          Text(
                            "Intensity level",
                            style: GoogleFonts.istokWeb(
                              color: Colors.black,
                              fontSize: isLandscape ? screenWidth * 0.025 : screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildRadioOption("Slow", screenWidth, screenHeight, isLandscape),
                              _buildRadioOption("Moderate", screenWidth, screenHeight, isLandscape),
                              _buildRadioOption("Vigorous", screenWidth, screenHeight, isLandscape),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Duration",
                            style: GoogleFonts.istokWeb(
                              color: Colors.black,
                              fontSize: isLandscape ? screenWidth * 0.025 : screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _buildInputRow("minutes", _durationController, screenWidth, screenHeight, isLandscape),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                      title: Text("🔥 Keep the fire burning!"),
                                      content: Text("Your activity has been recorded."),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pushReplacementNamed(context, "/exercise");
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF2EC4B6),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                ),
                              child: Text(
                                "Save Activity",
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

  Widget _buildActivitySelection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Activity",
          style: GoogleFonts.istokWeb(
            color: Colors.black,
            fontSize: isLandscape ? screenWidth * 0.025 : screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: isLandscape ? screenHeight * 0.03 : screenHeight * 0.04,
          child: TextField(
            controller: _activityController,
            onChanged: _filterActivitySuggestions,
            style: GoogleFonts.hankenGrotesk(
              fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.04,
            ),
            decoration: InputDecoration(
              hintText: "Type activity to search...",
              hintStyle: GoogleFonts.mukta(
                color: const Color.fromARGB(154, 0, 0, 0),
                fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.04,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty && value != selectedActivity) {
                setState(() {
                  selectedActivity = value;
                  _activityController.clear();
                  filteredSuggestions.clear();
                });
              }
            },
          ),
        ),
        _buildActivitySuggestionsList(screenWidth, screenHeight, isLandscape),
        SizedBox(height: 8),
        if (selectedActivity != null) // Show chip only if an activity is selected
          Chip(
            label: Text(
              selectedActivity!,
              style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.black),
            ),
            backgroundColor: Colors.orange.shade200,
            deleteIcon: Icon(Icons.close, size: screenWidth * 0.04),
            onDeleted: () {
              setState(() {
                selectedActivity = null;
              });
            },
          ),
      ],
    );
  }

  void _filterActivitySuggestions(String input) {
    setState(() {
      filteredSuggestions = activitySuggestions
          .where((activity) => activity.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  Widget _buildActivitySuggestionsList(double screenWidth, double screenHeight, bool isLandscape) {
    return filteredSuggestions.isNotEmpty
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              children: filteredSuggestions.map((suggestion) {
                return ListTile(
                  title: Text(
                    suggestion,
                    style: GoogleFonts.hankenGrotesk(
                    fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.04,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedActivity = suggestion;
                      _activityController.clear();
                      filteredSuggestions.clear();
                    });
                  },
                );
              }).toList(),
            ),
          )
        : SizedBox();
  }

  Widget _buildInputRow(String text, TextEditingController controller, double screenWidth, double screenHeight, bool isLandscape) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Ensures the row takes only the needed space
      children: [
        SizedBox(
          width: isLandscape ? screenWidth * 0.1 : screenWidth * 0.3,
          height: isLandscape ? screenHeight * 0.03 : screenHeight * 0.04,
          child: TextField(
            controller: controller,
            style: GoogleFonts.hankenGrotesk(
              fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.04,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.hankenGrotesk(
            fontSize: isLandscape ? screenWidth * 0.02 : screenWidth * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(String option, double screenWidth, double screenHeight, bool isLandscape) {
    return Row(
      children: [
        Radio(
          value: option,
          groupValue: selectedIntensity,
          onChanged: (value) {
            setState(() {
              selectedIntensity = value;
            });
          },
        ),
        Text(
          option,
          style: GoogleFonts.inter(
            fontSize: isLandscape ? screenWidth * 0.02 : screenWidth * 0.045,
            color: Colors.black,
            ),
        ),
      ],
    );
  }
}