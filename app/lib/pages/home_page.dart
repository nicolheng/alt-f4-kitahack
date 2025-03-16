import 'package:flutter/material.dart';

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
        _backgroundGradient(
          context,
        ),
        _buttons(
          context,
        )
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: transparent,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3, right: 20, left: 20),
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
                ),
                CategoryButton(
                  title: "Food",
                  icon: Icons.restaurant,
                  bgColor: Color(0x99FB9100),
                  onPressed: () {},
                ),
                CategoryButton(
                  title: "Profile",
                  icon: Icons.person,
                  bgColor: Color(0x99BEF1ED),
                  onPressed: () {},
                ),
                CategoryButton(
                  title: "Mood",
                  icon: Icons.emoji_emotions,
                  bgColor: Color(0x992EC4B6),
                  onPressed: () {},
                ),
              ],
            ),
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

  const CategoryButton({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.onPressed,
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
          Expanded(
            child: 
          ),
        ],
      ),
    );
  }
}