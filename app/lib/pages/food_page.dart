import 'package:flutter/material.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(context,),
    );
  }

  Widget _buildUI(BuildContext context){
    return Stack(
      children: [
        _backgroundGradient(context),
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
            color: Color(0xFFFF9F1C)
          ),
        ),
        Positioned(
          top: screenHeight*-0.2,
          right: screenWidth*-0.12,
          child: ClipOval(
            child:Container(
                width: 406,
                height: 406,
                color: Color(0x60FFFFFF),
              )
          ),
        ),
        Positioned(
            top: screenHeight*-0.15,
            left: screenWidth*-0.15,
          child: ClipOval(
            child:Container(
                width: 320,
                height: 320,
                color: Color(0x60FFFFFF),
              )
          ),
        ),
        Positioned(
          top: screenHeight*0.38,
          left: screenWidth*0.05,
          child: ClipOval(
            child:Container(
                width: 150,
                height: 150,
                color: Color(0x60FFFFFF),
              )
          ),
        ),
        Positioned(
          top: screenHeight*0.58,
          left: screenWidth*0.4,
          child: ClipOval(
            child:Container(
                width: 94,
                height: 94,
                color: Color(0x60FFFFFF),
              )
          ),
        ),
        Positioned(
          top: screenHeight*0.8,
          left: screenWidth*0.12,
          child: ClipOval(
            child:Container(
                width: 76,
                height: 76,
                color: Color(0x60FFFFFF),
              )
          ),
        ),
      ],
    );
  }
}