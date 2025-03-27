import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? _selectedDiet;
  final TextEditingController _medicalController = TextEditingController();
  final TextEditingController _otherAllergiesController = TextEditingController();

  List<String> dietOptions = ["Vegan", "Vegetarian", "Paleo", "Keto", "Halal", "None"];
  List<String> allergies = ["Peanuts", "Treenuts", "Dairy", "Wheat", "Eggs", "Soy", "Fish", "Sesame", "Shellfish", "Gluten"];
  Map<String, bool> selectedAllergies = {};

  List<String> allergySuggestions = ["Corn", "Chia seeds", "Buckwheat", "Chickpeas", "Carrots", "Celery", "Coconut", "Cherry", "Avocado", "Chicken", "Pork", "Crab", "Clams", "Cassava (Tapioca)", "Chocolate (Cocoa Allergy)", "Cinnamon", "Garlic", "Lactose (Milk Allergy/Intolerance)"];
  List<String> filteredSuggestions = [];
  List<String> selectedOtherAllergies = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: Container(
              width: isLandscape ? screenWidth * 0.6 : screenWidth * 0.9,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 16),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Green Container for Personal Info
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(187, 255, 255, 255),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Settings",
                            style: GoogleFonts.tiltWarp(
                              fontSize: isLandscape ? screenWidth * 0.03 : screenWidth * 0.06,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFF9F1C),
                            ),
                          ),
                          _buildDropdownSection("Diet Preference", dietOptions, _selectedDiet, (String? newValue) {
                            setState(() {
                              _selectedDiet = newValue;
                            });
                          }),
                          SizedBox(height: screenHeight * 0.005),
                          _buildInputSection("Medical Conditions", _medicalController),
                          SizedBox(height: screenHeight * 0.005),
                          _buildAllergyCheckboxes(),
                          SizedBox(height: screenHeight * 0.005),
                          _buildOtherAllergySection(),
                          SizedBox(height: screenHeight * 0.03),

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
                                      title: Text("Settings Saved!"),
                                      content: Text("Thank you for updating your settings! We've noted your preferences and will tailor your experience accordingly. Get ready to enjoy a more personalized experience!"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pushReplacementNamed(context, "/welcome");
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
                                "Save Settings",
                                style:GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.035,
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
          
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.05,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacementNamed(context, "/welcome"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSection(String title, List<String> options, String? selectedValue, Function(String?) onChanged) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.mukta(
            color: Color(0xFFFFBF69),
            fontSize: isLandscape ? screenWidth * 0.03 : screenWidth * 0.045,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          hint: Text(
            "Select your diet preference",
            style: GoogleFonts.mukta(
            fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.04,
            ),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildInputSection(String title, TextEditingController controller) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.mukta(
            color: Color(0xFFFFBF69),
            fontSize: isLandscape ? screenWidth * 0.025 : screenWidth * 0.045,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter your medical conditions",
            hintStyle: GoogleFonts.mukta(
              color: const Color.fromARGB(154, 0, 0, 0),
              fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.04,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildAllergyCheckboxes() {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Your Allergies",
          style: GoogleFonts.mukta(
            color: Color(0xFFFFBF69),
            fontSize: isLandscape ? screenWidth * 0.025 : screenWidth * 0.045,
          ),
        ),
        SizedBox(height: 8),
          GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 4,
            childAspectRatio: 4, // Adjust row height
          ),
          itemCount: allergies.length,
          itemBuilder: (context, index) {
            return _buildCheckbox(allergies[index]);
          },
        ),
      ],
    );
  }

  Widget _buildCheckbox(String allergy) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: selectedAllergies[allergy] ?? false,
          onChanged: (bool? value) {
            setState(() {
              selectedAllergies[allergy] = value!;
            });
          },
        ),
        Text(
          allergy,
          style: GoogleFonts.mukta(
              color: Color(0xFF2EC4B6),
              fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.045,
            ),
          ),
      ],
    );
  }

  Widget _buildOtherAllergySection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Other Allergies",
          style: GoogleFonts.mukta(
            color: Color(0xFFFFBF69),
            fontSize: isLandscape ? screenWidth * 0.025 : screenWidth * 0.045,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _otherAllergiesController,
          onChanged: _filterSuggestions,
          decoration: InputDecoration(
            hintText: "Type to search...",
            hintStyle: GoogleFonts.mukta(
              color: const Color.fromARGB(154, 0, 0, 0),
              fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.04,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty && !selectedOtherAllergies.contains(value)) {
              setState(() {
                selectedOtherAllergies.add(value);
                _otherAllergiesController.clear();
                filteredSuggestions.clear();
              });
            }
          },
        ),
        _buildSuggestionsList(),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: selectedOtherAllergies.map((allergy) {
            return Chip(
              label: Text(
                allergy,
                style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.black),
              ),
              backgroundColor: Colors.orange.shade200,
              deleteIcon: Icon(Icons.close, size: screenWidth * 0.04),
              onDeleted: () {
                setState(() {
                  selectedOtherAllergies.remove(allergy);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _filterSuggestions(String input) {
    setState(() {
      filteredSuggestions = allergySuggestions.where((allergy) => allergy.toLowerCase().contains(input.toLowerCase())).toList();
    });
  }

  Widget _buildSuggestionsList() {
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
                  title: Text(suggestion),
                  onTap: () {
                    if (!selectedOtherAllergies.contains(suggestion)) {
                      setState(() {
                        selectedOtherAllergies.add(suggestion);
                        _otherAllergiesController.clear();
                        filteredSuggestions.clear();
                      });
                    }
                  },
                );
              }).toList(),
            ),
          )
        : SizedBox();
  }


  Widget _buildBackground() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFF2EC4B6).withOpacity(0.3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          _buildCircle(left: screenWidth * 0.03, top: screenHeight * 0.05, size: screenWidth * 0.09, color: Colors.white.withOpacity(0.9)),
          _buildCircle(left: screenWidth * 0.03, top: screenHeight * 0.05, size: screenWidth * 0.09, color: Color(0x66BEF0EC)),
          _buildCircle(left: screenWidth * 0.42, top: screenHeight * 0.09, size: screenWidth * 0.09, color: Colors.white.withOpacity(0.9)),
          _buildCircle(left: screenWidth * 0.71, top: screenHeight * 0.45, size: screenWidth * 0.14, color: Color(0x992EC4B6)),
          _buildCircle(left: screenWidth * 0.51, top: screenHeight * 0.42, size: screenWidth * 0.07, color: Color(0xFF50F2E3)),
          _buildCircle(left: screenWidth * -0.03, top: screenHeight * 0.1, size: screenWidth * 0.07, color: Color(0xFF96ECE5)),
          _buildCircle(left: screenWidth * 0.12, top: screenHeight * 0.06, size: screenWidth * 0.28, color: Color(0xFFE3FFFC)),
          _buildCircle(left: screenWidth * 0.71, top: screenHeight * 0.25, size: screenWidth * 0.45, color: Color(0xFF96ECE5)),
          _buildCircle(left: screenWidth * -0.3, top: screenHeight * 0.7, size: screenWidth * 0.75, color: Color(0xFF50F2E3)),
          _buildCircle(left: screenWidth * 0.28, top: screenHeight * 0.85, size: screenWidth * 0.75, color: Color(0xFF2EC4B6)),
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
}