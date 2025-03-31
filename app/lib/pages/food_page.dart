import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

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
        _content(context),
      ],
    );
  }

  // Backgrounds
  Widget _backgroundGradient(BuildContext context) {
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

  // Contents
  Widget _content(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                padding: EdgeInsets.fromLTRB(20,20,0,0),
                onPressed: () => Navigator.pushNamed(context, "/welcome"), 
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

        // Meal History
        Positioned(
          top: screenHeight*0.15,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.92,
              height: screenHeight * 0.22,
              decoration: BoxDecoration(
                color: const Color(0x99FFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Expanded(
                    child: Text(
                      "Your Latest Meal",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0x99C46F2E),
                      ),
                    )
                  ),

                  // Last Meal Box
                  Expanded(
                    child: Positioned(
                      left: 15,
                      right: 15,
                      top: 25,
                      bottom: 23,
                      child: Container(
                        width: screenWidth*0.85,
                        height: screenHeight*0.15,
                        decoration: BoxDecoration(
                          color: Color(0x80EFA23A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 5,
                              child: Text("Calories\t\t309\nCarbohydrate\t3%",
                                style: GoogleFonts.poppins(fontSize: 12)
                              ),
                            ),

                            Positioned(
                              right: 5,
                              top: 5,
                              bottom: 0,
                              child: Column(
                                children: [
                                  Flexible(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: AutoSizeText(
                                        "Chicken Caeser Salad",
                                        style: GoogleFonts.anton(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth*0.4,
                                    height: screenHeight*0.1,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("asset/food/chicken-caesar-salad.png") //Change this later on when meal history is done
                                        )
                                    ),
                                  )
                                ],
                              )
                            )
                          ],
                        )
                      ),
                    ),
                  ),
                  
                  // View More button
                  Expanded(
                    child:Positioned(
                      right: 10,
                      bottom: -10,
                      child: ElevatedButton(
                        onPressed: () {print("AwMan");},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          elevation: 3,
                          minimumSize: Size(screenWidth*0.0001, screenHeight*0.005),
                        ),
                        child: const Text("View More",style: TextStyle(color: Colors.white),),
                      )
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
        

        // Recipe Recommendations
        Positioned(
          top: screenHeight*0.38,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.92,
              height: screenHeight * 0.56,
              decoration: BoxDecoration(
                color: const Color(0x99FFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [

                  // Expand Button
                  Positioned(
                    top: 2,
                    right: 3,
                    child: IconButton(
                      onPressed: () {
                        print("ENLARGE");
                      },
                      icon: const Icon(Ionicons.expand_outline, size: 30),
                    ),
                  ),

                  // Searchbar
                  Positioned(
                    top: 15,
                    left: 30,
                    right: 50,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xCCFFFFFF)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search_outlined,
                              color: Colors.amber, size: 19
                              ),
                          const SizedBox(width: 10),
                          Text("Search Recipe",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w400
                              )),
                        ],
                      ),
                    ),
                  ),


                  // Recipes placeholder
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight*0.04, right: 10, left: 10),
                    child: GridView.count(
                      shrinkWrap: false,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.6, // Adjust height-to-width ratio
                      children: [
                        RecipeBox(recipeName: "recipeName", difficulty: "Easy", image: "asset/food/frittataPIC.png", onPressed: (){print("Yeah");}, calories: "200 Cal"),
                        RecipeBox(recipeName: "recipeName", difficulty: "Medium", image: "asset/food/frittataPIC.png", onPressed: (){print("Yeah");}, calories: "200 Cal"),
                        RecipeBox(recipeName: "recipeName", difficulty: "Hard", image: "asset/food/frittataPIC.png", onPressed: (){print("Yeah");}, calories: "200 Cal"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      
        // Camera Button
        Align(
          alignment: Alignment.bottomCenter,
          child:Padding(
            padding: EdgeInsets.fromLTRB(screenWidth*0.047, 0, screenWidth*0.047, screenHeight*0.04),
            child: Row(
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: AutoSizeText(
                      "Search for a recommended dish",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patrickHandSc(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth*0.02,),
                FloatingActionButton(
                  onPressed: () => Navigator.pushNamed(context, "/foodcamera"), 
                  backgroundColor: Colors.white,
                      child: const Icon(Icons.camera_alt, color: Colors.orange, size: 30),
                ),
                SizedBox(width: screenWidth*0.02,),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: AutoSizeText(
                      "Or scan what's on your fridge",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patrickHandSc(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Recipe Widgets
class RecipeBox extends StatelessWidget {
  final String recipeName;
  final String difficulty;
  final String image;
  final VoidCallback onPressed;
  final String calories;

  const RecipeBox({
    required this.recipeName,
    required this.difficulty,
    required this.image,
    required this.onPressed,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Card background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        padding: EdgeInsets.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x80EFA23A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Stack(children: [
                Positioned(
                  top: -5,
                  left: 5,
                  child: Text(
                    recipeName,
                    style: GoogleFonts.pathwayGothicOne(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
                Positioned(
                  bottom: 2,
                  left: 5,
                  child: Column(
                    children: [
                      _difficultyTag(difficulty)
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: Text(
                    calories
                  ),
                )
              ],),
            ),
          ),
        ],
      ),
    );
  }

  Widget _difficultyTag(String difficulty) {
    Color bgColor;
    if (difficulty == "Easy") {
      bgColor = Colors.greenAccent;
    } else if (difficulty == "Medium") {
      bgColor = Colors.orangeAccent;
    } else {
      bgColor = Colors.redAccent;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        difficulty,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

