import 'dart:io';

import 'package:alt_f4/pages/food_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageRecognizer extends StatefulWidget {
  final File imageCaptured;
  final bool isRecipeSelected;
  const ImageRecognizer({super.key, required this.imageCaptured, required this.isRecipeSelected});

  @override
  State<ImageRecognizer> createState() => _ImageRecognizerState();
}

class _ImageRecognizerState extends State<ImageRecognizer> {
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _backgroundGradient(context),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
        
              // Switch Between Find Dish or Find Recipe from ingredients
              if (widget.isRecipeSelected == true) ...[
                FindDish(imageCaptured: widget.imageCaptured,),
              ]else ...[
                FindRecipe(imageCaptured: widget.imageCaptured,)
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _backgroundGradient(BuildContext context){
    return Stack(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  Color(0xFF38353D),
                  Color(0xffffb56b),
                ], //
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FindDish extends StatefulWidget {
  final File imageCaptured;
  const FindDish({super.key, required this.imageCaptured});

  @override
  State<FindDish> createState() => _FindDishState();
}

class _FindDishState extends State<FindDish> {
  String? selectedMeal;
  List<String> meals = ["Breakfast","Lunch","Dinner","Supper"];
  List<String> ingredients = ["Eggs","Cucumber","Rice"];
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void clearText(){
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addIngredient(){
    String inputOther = _controller.text;
    ingredients.add(inputOther);
    clearText();
    setState(() {});
  }

  void removeButton(int index){
    setState(() {
      ingredients.removeAt(index);
    });
  }

  void addItem(String value){
    setState(() {
      ingredients.add(value);
    });
  }
  
  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    String foodName = "No Food Found";

    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, screenHeight*0.05, screenWidth*0.05, 0),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, "/camera"),
              icon: Icon(Ionicons.exit_outline, size: 30, color: Colors.white,),
            ),
          ),
        ),
        
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, screenHeight*0.05, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: AutoSizeText(
                      "Is This Correct?",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 16,color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 5,),

                // Captured Image
                SizedBox(
                  width: screenWidth*0.4,
                  height: screenHeight*0.4,
                  child: Image.file(File(widget.imageCaptured.path)),
                ),
                SizedBox(height: 5,),       

                // Returned Food Name (default: No Food Found)
                Flexible(
                  fit: FlexFit.loose,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: AutoSizeText(
                      foodName,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                // Ingredients Viewbox
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth*0.05,0,screenWidth*0.05,0),
                  child: Wrap(
                    children: List.generate(ingredients.length, (index){
                      return Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: IngredientsBox(
                          ingredientName: ingredients[index],
                          onPressed: () => removeButton(index),
                        ),
                      );
                    }),
                  ),
                ),

                // Other Inputs
                Padding(
                  padding: EdgeInsets.only(left: screenWidth*0.05,right: screenWidth*0.05, top: 10),
                  child: SizedBox(
                    width: screenWidth*0.9,
                    height: screenHeight*0.05,
                    child: Row(
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: AutoSizeText(
                              "Others? : ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 2.0),
                          child: Material(
                            color: Color(0xFF817F84),
                            child: SizedBox(
                              width: screenWidth*0.45,
                              height: screenHeight*0.05,
                              child: TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  hintText: "Enter text",
                                ),
                              ),
                            ),
                          ),
                        ),
                    
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: ElevatedButton(
                            onPressed: (){_addIngredient();}, 
                            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.orange)),
                            child: Flexible(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: AutoSizeText(
                                  "Add",
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Current Meal
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth*0.05, 10, screenWidth*0.05, 0),
                  child: SizedBox(
                    width: screenWidth*0.8,
                    height: screenHeight*0.05,
                    child: Row(
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: AutoSizeText(
                              "Meal :",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 2.0),
                          child: Material(
                            color: Color(0xFF817F84),
                            child: DropdownButton<String>(
                              value: selectedMeal,
                              hint: Text("Select Meal", textAlign: TextAlign.center,),
                              items: meals
                                  .map((meal) => DropdownMenuItem<String>(
                                        value: meal,
                                        child: Text(meal.toString(), textAlign: TextAlign.center,),
                                      ))
                                  .toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedMeal = newValue;
                                });
                              },
                              icon: Icon(Icons.arrow_drop_down),
                              style: TextStyle(fontSize: 16, color: Colors.black),
                              dropdownColor: Colors.white,
                              elevation: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0,10,0,0),
                  child: Flexible(
                    fit: FlexFit.loose,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: AutoSizeText(
                        "-- Dish Found --",
                        style: GoogleFonts.podkova(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: GridView.count(
                    shrinkWrap: true,
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
                
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: ElevatedButton(
                    onPressed: (){print("Added to food history");}, 
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF))),
                    child: Flexible(
                      fit: FlexFit.loose,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: AutoSizeText(
                          "Add to Food History",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 12),
                        ),
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
}

class FindRecipe extends StatefulWidget {
  final File imageCaptured;
  const FindRecipe({super.key, required this.imageCaptured});

  @override
  State<FindRecipe> createState() => _FindRecipeState();
}

class _FindRecipeState extends State<FindRecipe> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class IngredientsBox extends StatelessWidget {
  final String ingredientName;
  final VoidCallback onPressed;

  const IngredientsBox({
    required this.ingredientName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0x4D92899F), // Card background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        padding: EdgeInsets.all(2),
      ),
      child: Container(
        width: screenWidth*0.25,
        height: screenHeight*0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.transparent
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Flexible(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: AutoSizeText(
                    " $ingredientName",
                    style: GoogleFonts.podkova(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white, backgroundColor: Colors.transparent),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(Ionicons.remove_outline, color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }
}