import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FoodHistoryPage extends StatelessWidget {
  const FoodHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Stack(
      children: [
        _background(context),
        _content(context),
      ],
    );
  }

  Widget _background(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(color: Color(0xFFFF9F1C)),
        ),
        Positioned(
          top: screenHeight * -0.2,
          right: screenWidth * -0.12,
          child: ClipOval(
            child: Container(
              width: 406,
              height: 406,
              decoration: const BoxDecoration(color: Color(0x60FFFFFF)),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * -0.15,
          left: screenWidth * -0.15,
          child: ClipOval(
            child: Container(
              width: 320,
              height: 320,
              decoration: const BoxDecoration(color: Color(0x60FFFFFF)),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.38,
          left: screenWidth * 0.05,
          child: ClipOval(
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(color: Color(0x60FFFFFF)),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.58,
          left: screenWidth * 0.4,
          child: ClipOval(
            child: Container(
              width: 94,
              height: 94,
              decoration: const BoxDecoration(color: Color(0x60FFFFFF)),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.8,
          left: screenWidth * 0.12,
          child: ClipOval(
            child: Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(color: Color(0x60FFFFFF)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _content(BuildContext context){
    int dailyCalory = 800;
    DateTime now = DateTime.now();

    List<String> dateList = [
    DateFormat('EEEE, d MMM, yyyy').format(DateTime(now.year, now.month, now.day)),
    DateFormat('EEEE, d MMM, yyyy').format(DateTime(now.year, now.month, now.day-1)),
    DateFormat('EEEE, d MMM, yyyy').format(DateTime(now.year, now.month, now.day-2)),
    DateFormat('EEEE, d MMM, yyyy').format(DateTime(now.year, now.month, now.day-3)),
    DateFormat('EEEE, d MMM, yyyy').format(DateTime(now.year, now.month, now.day-4)),
  ];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
        children: [
          // Header
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: EdgeInsets.fromLTRB(20,20,0,0),
                  onPressed: () => Navigator.pushNamed(context, "/food"), 
                  icon: Icon(Icons.arrow_back_rounded, color: Colors.black,),
                ),
              ),
              SizedBox(height: 10,),

              // Title
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight*0.02),
                  child: Flexible(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: AutoSizeText(
                        "Your Personal\nFood Tracking Assistant",
                        style: GoogleFonts.tiltWarp(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          //Main Content
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: screenWidth*0.9,
              height: screenHeight*0.85,
              decoration: BoxDecoration(
                color: Color(0x80FFC577),
                borderRadius: BorderRadius.circular(5),
              ),

              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Container(
                      width: screenWidth*0.85,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0xFF68410B), width: 1),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                                child: Text(
                                  "From: ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black87,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              
                              Padding(
                                padding: EdgeInsets.only(left: 3,top: 5, bottom: 5),
                                child: Container(
                                  width: screenWidth*0.28,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFB147)
                                  ),
                                ),
                              ),
                          
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                                child: Text(
                                  "Till: ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black87,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              
                              Padding(
                                padding: EdgeInsets.only(left: 3, top: 5, bottom: 5),
                                child: Container(
                                  width: screenWidth*0.28,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFB147)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // History List
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: SizedBox(
                      width: screenWidth*0.85,
                      height: screenHeight*0.75,
                      child: GridView.count(
                        shrinkWrap: false,
                        crossAxisCount: 1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 2, // Adjust height-to-width ratio
                        children:
                          List.generate(dateList.length, (index){
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5, top: 0),
                                  child: Text(
                                    //dateList[index].toString().replaceAll("00:00:00.000", ""),
                                    dateList[index],
                                    style: GoogleFonts.poppins(
                                      color: Colors.black87,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                      
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
                                  child: Container(
                                    width: screenWidth*0.8,
                                    height: screenHeight*0.2,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFE4BF),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0, top: 10),
                                              child: Container(
                                                width: screenWidth*0.3,
                                                height: screenHeight*0.15,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFFFBF69),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Column(
                                                  children: [
                                                    AutoSizeText(
                                                      "Breakfast",
                                                      style: GoogleFonts.poppins(
                                                        color: Colors.black87,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w900,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    Spacer(),
                                                    AutoSizeText(
                                                      "Oats and Milk",
                                                      style: GoogleFonts.poppins(
                                                        color: Colors.black87,
                                                        fontSize: 8,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 5.0),
                                            child: AutoSizeText(
                                              "Total Calories: $dailyCalory",
                                              textAlign: TextAlign.right,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black87,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })
                                      
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 0, top: 2),
                        child: AutoSizeText(
                          "Average Calorie Intake (day): ",
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 5, left: 0, top: 2),
                        child: AutoSizeText(
                          "1300cal",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }
}