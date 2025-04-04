import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.9,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: screenHeight * 0.02,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  SizedBox(height: screenHeight * 0.03),
                  AutoSizeText(
                    "Terms & Conditions",
                    style: GoogleFonts.itim(
                      color: Colors.black,
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildTermsnConditions(screenWidth, screenHeight),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.02,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: AutoSizeText(
                        "Back", 
                        style: TextStyle(color: Colors.white)
                      ),
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

  List<Widget> _buildTermsnConditions(double screenWidth, double screenHeight) {
    return [
      _buildSection("1. Acceptance of Terms",
          "By downloading or using Poutato, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions and our Privacy Policy.", screenWidth),
      _buildSection("2. User Accounts",
          "To use certain features of Poutato, you may need to create an account. You agree to provide accurate information, maintain security, and notify us of any security breaches.", screenWidth),
      _buildSection("3. Use of the App",
          "You agree to use Poutato only for lawful purposes and in accordance with these Terms.", screenWidth),
      _buildSection("4. User Conduct",
          "You are solely responsible for your conduct and content while using the app.", screenWidth),
      _buildSection("5. Content Sharing",
          "When you share content via Poutato, you grant us a non-exclusive, worldwide, royalty-free license to use it.", screenWidth),
      _buildSection("6. Third-Party Links",
          "Poutato may contain links to third-party websites or services that we do not control.", screenWidth),
      _buildSection("7. Disclaimers",
          "Poutato is provided on an 'as-is' and 'as-available' basis without warranties.", screenWidth),
      _buildSection("8. Limitation of Liability",
          "We are not liable for indirect, incidental, or special damages arising from the use of Poutato.", screenWidth),
      _buildSection("9. Changes to Terms",
          "We may revise these Terms and Conditions and will notify users by updating this page.", screenWidth),
      _buildSection("10. Governing Law",
          "These Terms are governed by the laws of Malaysia.", screenWidth),
      _buildSection("11. Contact Us",
          "For questions about these Terms and Conditions, contact us at poutatovideocon@gmail.com.", screenWidth),
      SizedBox(height: screenHeight * 0.03),
    ];
  }

  Widget _buildSection(String title, String content, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          AutoSizeText(
            content,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
