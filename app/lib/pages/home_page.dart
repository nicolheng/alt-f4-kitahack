import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElevatedButtons extends StatefulWidget {
  const ElevatedButtons({super.key});

  @override
  State<ElevatedButtons> createState() => _ElevatedButtonState();
}

class _ElevatedButtonState extends State<ElevatedButtons> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(style: style, onPressed: () {
            Navigator.pushNamed(context, "/login");
          }, child: const Text('Enabled')),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const Color transparent = Color(0x00000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(context,),
    );
  }

  Widget _buildUI(BuildContext context){
    return Stack(
      children: [
        _backgroundGradient(context,),
        _buttons(context,)
      ],
    );
  }

  Widget _backgroundGradient(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white10
            ),
          ),
          Positioned(
            top: screenHeight*0.3,
            left: screenWidth*-0.055,
            child: ClipOval(
              child:Container(
                width: 52,
                height: 52,
                color: Color.fromARGB(90, 149, 228, 223),
              )
            )
          ),
          Positioned(
            top: screenHeight*-0.1,
            right: screenWidth*-0.1,
            child: ClipOval(
              child:Container(
                width: 201,
                height: 201,
                color: Color.fromARGB(70, 255, 191, 105),
              )
            )
            
          ),
          Positioned(
            bottom: screenHeight*-0.1,
            right: screenWidth*0.25,
            child: ClipOval(
              child:Container(
                width: 192,
                height: 192,
                color: Color.fromARGB(70, 46, 196, 182),
              )
            )
          ),
          Positioned(
            bottom: screenHeight*0.23,
            right: screenWidth*-0.1,
            child: ClipOval(
              child:Container(
                width: 83,
                height: 83,
                color: Color.fromARGB(90, 149, 228, 223),
              )
            )
          ),
          Positioned(
            bottom: screenHeight*-0.04,
            right: screenWidth*-0.1,
            child: ClipOval(
              child:Container(
                width: 245,
                height: 245,
                color: Color.fromARGB(70, 255, 191, 105),
              )
            )
          ),
      ],
    );
  }

  Widget _buttons(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: transparent,
        body: Center(
          child: Stack(
            children: [

              // Buttons
              Padding(
                padding: EdgeInsets.only(top: screenHeight*0.35, right: 20, left: 20),
                child: GridView.count(
                  shrinkWrap: false,
                  crossAxisCount: 2, // Two buttons per row
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2, // Adjust height-to-width ratio
                  children: [
                    CategoryButton(
                      title: "Exercise",
                      icon: Icons.directions_run,
                      bgColor: Color(0x99FFBF69),
                      onPressed: () {},
                      iconImg: "asset/homepage/footsteps.png",
                    ),
                    CategoryButton(
                      title: "Food",
                      icon: Icons.restaurant,
                      bgColor: Color(0x99FB9100),
                      onPressed: () {},
                      iconImg: "asset/homepage/recipe_book.png",
                    ),
                    CategoryButton(
                      title: "Profile",
                      icon: Icons.person,
                      bgColor: Color(0x99BEF1ED),
                      onPressed: () {},
                      iconImg: "asset/homepage/resume.png",
                    ),
                    CategoryButton(
                      title: "Mood",
                      icon: Icons.emoji_emotions,
                      bgColor: Color(0x992EC4B6),
                      onPressed: () {},
                      iconImg: "asset/homepage/fern.png",
                    ),
                  ],
                ),
              ),

              //Profile Picture
              Padding(
                padding: EdgeInsets.only(top: screenHeight*0.06, left: screenWidth*0.1),
                child:ClipOval(
                  child: Container(
                    width: screenHeight*0.25,
                    height: screenHeight*0.25,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      image: DecorationImage(
                        image: AssetImage("asset/homepage/default_profile.png"),
                        fit: BoxFit.cover, 
                      ),
                    ),
                  ),
                )
              ),

              //Welcome User
              Padding(
                padding: EdgeInsets.only(top: screenHeight*0.09, left: screenWidth*0.57),
                child: Text(
                  "Welcome Back,\nFellow User...",
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Elevated Button Widget
class CategoryButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final VoidCallback onPressed;
  final String iconImg;

  const CategoryButton({
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
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                image: DecorationImage(
                  image: AssetImage(iconImg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment(-0.9,-0.85),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                      )
                    ]
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: Icon(
                      icon, 
                      size: 30, 
                      shadows: <Shadow>[Shadow(color: Colors.black12, blurRadius: 8.0, offset: Offset(0, 2.0))],
                      color: bgColor,
                    ),
                  ),
                ),
              )
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
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