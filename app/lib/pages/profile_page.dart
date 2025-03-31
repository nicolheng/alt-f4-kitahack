import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
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
        _mainProfile(context,),
        _profileDetails(context,),
      ],
    );
  }

  Widget _backgroundGradient(BuildContext context){
    return Stack(
      children: [
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFBEF1ED)
                ),
                child: Stack(
                    children: [
                        Positioned(
                            left: 58,
                            top: 0,
                            child: Container(
                                width: 165,
                                height: 165,
                                decoration: ShapeDecoration(
                                    color: const Color(0x4C2EC4B6),
                                    shape: OvalBorder(),
                                ),
                            ),
                        ),
                        Positioned(
                            left: 315,
                            top: 119,
                            child: Container(
                                width: 122,
                                height: 122,
                                decoration: ShapeDecoration(
                                    color: const Color(0x4C2EC4B6),
                                    shape: OvalBorder(),
                                ),
                            ),
                        ),
                        Positioned(
                            left: 144,
                            top: 250,
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: ShapeDecoration(
                                    color: const Color(0x4C2EC4B6),
                                    shape: OvalBorder(),
                                ),
                            ),
                        ),
                        Positioned(
                            left: 0,
                            top: 624.56,
                            child: Container(
                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.52),
                                width: 163.13,
                                height: 163.13,
                                decoration: ShapeDecoration(
                                    color: const Color(0x4C2EC4B6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                    ),
                                ),
                            ),
                        ),
                        Positioned(
                            left: 346.17,
                            top: 676,
                            child: Container(
                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(0.52),
                                width: 184.64,
                                height: 184.64,
                                decoration: ShapeDecoration(
                                    color: const Color(0x4C2EC4B6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                    ),
                                ),
                            ),
                        ),
                        Positioned(
                            left: 268,
                            top: 695.03,
                            child: Container(
                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.26),
                                width: 73.52,
                                height: 73.52,
                                decoration: ShapeDecoration(
                                    color: const Color(0x4C2EC4B6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                    ),
                                ),
                            ),
                        ),
                        Positioned(
                            left: 376,
                            top: 492.34,
                            child: Container(
                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.26),
                                width: 39.94,
                                height: 39.94,
                                decoration: ShapeDecoration(
                                    color: const Color(0x4C2EC4B6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                    ),
                                ),
                            ),
                        ),
                        Positioned(
                            left: 79,
                            top: 513.35,
                            child: Container(
                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.47),
                                width: 16.09,
                                height: 16.09,
                                decoration: ShapeDecoration(
                                    color: const Color(0x4C2EC4B6),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                            ),
                        ),
                        Positioned(
                            left: 322.97,
                            top: 352,
                            child: Container(
                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(0.52),
                                width: 39.94,
                                height: 39.94,
                                decoration: ShapeDecoration(
                                    color: const Color(0x4C2EC4B6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                    ),
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

  Widget _mainProfile(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Stack(
        children: [
            // Return Button
            Positioned(
                top: screenHeight*0.025,
                left: screenWidth*0.05,
                child: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/welcome"), 
                    icon: Icon(Icons.arrow_back_rounded, color: Colors.black,),
                ),
            ),

            // Avatar
            Positioned(
                top: screenHeight*0.035,
                left: screenWidth*0.25,
                right: screenWidth*0.25,
                child: Container(
                    width: screenWidth*0.5,
                    height: screenWidth*0.5,
                    decoration: BoxDecoration(
                        color: Color(0xFF2EC4B6),
                        borderRadius: BorderRadius.circular(100000),
                        image: DecorationImage(
                            image: AssetImage("asset/profile/defaultProfile.png"), // Need to allow to change profile picture later
                            fit: BoxFit.fitHeight,
                        ), 
                    ),
                ),
            ),

            // Edit Profile Button
            Positioned(
                top: screenHeight*0.23,
                left: screenWidth*0.67-20,
                right: screenWidth*0.23,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: CircleBorder(),
                    ),
                    onPressed: (){print("Editing Profile");}, 
                    child: Icon(Icons.create_outlined, color: Colors.black),
                ),
            ),
    
            // Name Title
            Positioned(
                top: screenHeight*0.31,
                left: 0,
                right: 0,
                child: Text(
                    "Some Random Name",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 32),
                    textAlign: TextAlign.center,
                ),
            ),

        ],
    );
  }

  Widget _profileDetails(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    String status = "Not Stated";
    var boxcolor = Color(0xFFEC640D);
    status == "Not Stated" ? boxcolor = Color(0xFFEC640D) : boxcolor = Color(0xFF9BDE5B);
    
    return Stack(
        children: [
          // Profile Settings Container
          Positioned(
            top: screenHeight * 0.38,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: Container(
              padding: EdgeInsets.fromLTRB(15,10,15,10),
              width: screenWidth * 0.8,
              height: screenHeight * 0.58,
              decoration: BoxDecoration(
              color: Color(0x66FFFFFF),
              borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),

                // Weights and Heights Inputs
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("Weight", style: GoogleFonts.rationale(fontSize: 24, fontWeight: FontWeight.w300),),
                    ),                    
                    ListWheelPicker(
                      initialValue: 50, 
                      itemCount: 200, 
                      onSelectedItemChanged: (value){print("Selected: $value");}
                    ),
                    SizedBox(height: screenHeight*0.01,),
                    Center(child: Text("Height", style: GoogleFonts.rationale(fontSize: 24, fontWeight: FontWeight.w300),),),
                    ListWheelPicker(
                      initialValue: 151,
                      itemCount: 251,
                      onSelectedItemChanged: (value){print("Selected: $value");}
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(top: screenHeight*0.01, left: screenWidth*0.04),
                          child: Center(
                            child: Column(
                              children: [
                                Text("Gender", style: GoogleFonts.rationale(fontSize: 24, fontWeight: FontWeight.w300),),
                                GenderButton(),
                              ],
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: screenHeight*0.01, left: screenWidth*0.1),
                          child: Center(
                            child: Column(
                              children: [
                                Text("Age", style: GoogleFonts.rationale(fontSize: 24, fontWeight: FontWeight.w300),),
                                Container(
                                  width: screenWidth*0.3,
                                  height: screenHeight*0.06,
                                  decoration: BoxDecoration(color: Color(0xFFE2E9E9), borderRadius: BorderRadius.circular(10)),
                                  child:Center(
                                    child: AgeDropdown(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(top: screenHeight*0.01, left: screenWidth*0.04),
                          child: Center(
                            child: Column(
                              children: [
                                Text("Diet Preference", style: GoogleFonts.rationale(fontSize: 24, fontWeight: FontWeight.w300),),
                                Container(
                                  width: screenWidth*0.3,
                                  height: screenHeight*0.05,
                                  decoration: BoxDecoration(color: boxcolor, borderRadius: BorderRadius.circular(10)),
                                  child: Center(child: Text(status, style: GoogleFonts.vt323(color: Colors.white, fontSize: 24),textAlign: TextAlign.center,)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: screenHeight*0.01, left: screenWidth*0.1),
                          child: Center(
                            child: Column(
                              children: [
                                Text("Allergies", style: GoogleFonts.rationale(fontSize: 24, fontWeight: FontWeight.w300),),
                                Container(
                                  width: screenWidth*0.3,
                                  height: screenHeight*0.05,
                                  decoration: BoxDecoration(color: boxcolor, borderRadius: BorderRadius.circular(10),),
                                  child: Center(child: Text(status, style: GoogleFonts.vt323(color: Colors.white, fontSize: 24),textAlign: TextAlign.center)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight*0.03,),
                    Center(child: ElevatedButton(onPressed: (){print("Request Edit");}, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF7CE5DD)), child: Text("Edit Profile", style: GoogleFonts.geo(color: Colors.black, fontSize: 20),))),
                  ],
                ),
              ),
            ),
          ),
        ],
    );
  }
}


class ListWheelPicker extends StatefulWidget {
  final int initialValue;
  final int itemCount;
  final double itemWidth;
  final ValueChanged<int> onSelectedItemChanged;

  const ListWheelPicker({
    super.key,
    required this.initialValue,
    required this.itemCount,
    this.itemWidth = 40.0,
    required this.onSelectedItemChanged,
  });

  @override
  _ListWheelPickerState createState() => _ListWheelPickerState();
}

class _ListWheelPickerState extends State<ListWheelPicker> {
  late FixedExtentScrollController scrollController;
  late int selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialValue;
    scrollController = FixedExtentScrollController(initialItem: selected);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    

    return SizedBox(
      height: screenHeight*0.06,
      child:ClipRect(
        child: RotatedBox(
          quarterTurns: -1,
          child: ListWheelScrollView.useDelegate(
            controller: scrollController,
            itemExtent: widget.itemWidth,
            physics: FixedExtentScrollPhysics(),
            magnification: 1.2,
            useMagnifier: true,
            onSelectedItemChanged: (index) {
              setState(() {
                selected = index;
              });
              widget.onSelectedItemChanged(index);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: widget.itemCount,
              builder: (context, index) {
                double distance = (index - selected).abs().toDouble();
                double scale = ((distance-0.15).clamp(0.95,1.0));

                return RotatedBox(
                  quarterTurns: 1,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    width: index == selected ? 35 : 30 * scale,
                    height: index == selected ? 35 : 30 * scale,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: index == selected ? Color(0xFF2EC4B6) : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$index',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class GenderButton extends StatefulWidget{
  @override
  _GenderPickerState createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderButton>{
  var boxColor = Color(0xFFEC640D);
  double boxX = 0;
  String buttonText = "Unknown";

  void _changeState(){
    setState(() {
      boxX = (boxX == 2) ? -2:2;
      buttonText = (boxX == 2) ? "Male":"Female";
      print(boxX);
      boxColor = Color(0xFF2EC4B6);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: _changeState, 
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
      ),
      child: SizedBox(
        width: screenWidth*0.22,
        height: screenHeight*0.05,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          alignment: Alignment(boxX, 0),
          child: Container(
            width: screenWidth*0.18,
            height: screenHeight*0.05,
            color: boxColor,
            child: Text(buttonText, style: GoogleFonts.vt323(color: Colors.white, fontSize: 24),textAlign: TextAlign.center,),
          ),
        ),
      ),
    );
  }
}

class AgeDropdown extends StatefulWidget {
  @override
  _AgeDropdownState createState() => _AgeDropdownState();
}

class _AgeDropdownState extends State<AgeDropdown> {
  int? selectedAge;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedAge,
      hint: Text("Select Age", textAlign: TextAlign.center,),
      items: List.generate(100, (index) => index + 1)
          .map((age) => DropdownMenuItem<int>(
                value: age,
                child: Text(age.toString(), textAlign: TextAlign.center,),
              ))
          .toList(),
      onChanged: (int? newValue) {
        setState(() {
          selectedAge = newValue;
        });
      },
      icon: Icon(Icons.arrow_drop_down),
      style: TextStyle(fontSize: 16, color: Colors.black),
      dropdownColor: Colors.white,
      elevation: 4,
    );
  }
}
