import 'dart:io';
import 'package:camera/camera.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:alt_f4/pages/return_recipe.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';

late final GenerativeModel model;

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraPage({super.key, required this.cameras});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController cameraController;
  late Future<void> cameraValue;
  List<File> imagesList = [];
  bool isFlashOn = false;
  bool isRearCamera = true;
  bool isRecipeSelected = true;

  Future<File> saveImage(XFile image) async {
    final downlaodPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DCIM);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('$downlaodPath/$fileName');

    try {
      await file.writeAsBytes(await image.readAsBytes());
    } catch (_) {}

    return file;
  }

  void takePicture() async {
    XFile? image;

    if (cameraController.value.isTakingPicture ||
        !cameraController.value.isInitialized) {
      return;
    }

    if (isFlashOn == false) {
      await cameraController.setFlashMode(FlashMode.off);
    } else {
      await cameraController.setFlashMode(FlashMode.torch);
    }
    image = await cameraController.takePicture();

    if (cameraController.value.flashMode == FlashMode.torch) {
      setState(() {
        cameraController.setFlashMode(FlashMode.off);
      });
    }

    final file = await saveImage(image);
    MediaScanner.loadMedia(path: file.path);
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => ImageRecognizer(imageCaptured: file, isRecipeSelected:isRecipeSelected)));
    });
  }

  Future<void> startCamera(int camera) async {
    try {
      await cameraController.dispose();
    } catch (_) {}

    try {
      cameraController = CameraController(
        widget.cameras[camera],
        ResolutionPreset.high,
        enableAudio: false,
      );
      cameraValue = cameraController.initialize();
      setState(() {});
    } catch (e) {
      print('Camera init error: $e');
    }
  }

  Future<File?> takePictureAndReturnFile() async {
    try {
      if (cameraController.value.isTakingPicture || !cameraController.value.isInitialized) {
        return null;
      }

      await cameraController.setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
      final XFile image = await cameraController.takePicture();

      // Turn off flash if it was on
      if (isFlashOn) {
        await cameraController.setFlashMode(FlashMode.off);
      }

      final File file = await saveImage(image);
      MediaScanner.loadMedia(path: file.path);
      return file;
    } catch (e) {
      print("Error taking picture: $e");
      return null;
    }
  }

  Future<File?> pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final File file = File(pickedFile.path);
        MediaScanner.loadMedia(path: file.path); // optional
        return file;
      }
      return null;
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

  void sendToGemini(File file) async{
    try {
    // Read image bytes
    final Uint8List imageBytes = await file.readAsBytes();

    // Create input (image + text prompt)
    final content = [
      Content.multi([
        DataPart('image/png', imageBytes),
        TextPart('What is in this image?') // 📝 Customize your prompt
      ]),
    ];

    // Generate response
    print('model is ready: ${model != null}');
    final response = await model.generateContent(content);

    print('Gemini Response: ${response.text}');
    } catch (e) {
      print('Error sending to Gemini: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startCamera(0);
      initializeGemini();
    });
  }

  void initializeGemini() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      print("Missing API Key");
      return;
    }
    model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(255, 255, 255, .7),
        shape: const CircleBorder(),
        onPressed: () async {
          File? imageFile = await takePictureAndReturnFile();
          if (imageFile != null) {
            // Send to Gemini API
            print("Image captured: ${imageFile.path}");
            sendToGemini(imageFile);
          } else {
            print("No image selected or captured.");
          }
        },
        child: const Icon(
          Icons.camera_alt,
          size: 40,
          color: Colors.black87,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  width: size.width,
                  height: size.height,
                  child: CameraPreview(cameraController),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 5, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFlashOn = !isFlashOn;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(50, 0, 0, 0),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: isFlashOn
                              ? const Icon(
                                  Icons.flash_on,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.flash_off,
                                  color: Colors.white,
                                  size: 30,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7, bottom: 75),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: imagesList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                height: 100,
                                width: 100,
                                opacity: const AlwaysStoppedAnimation(07),
                                image: FileImage(
                                  File(imagesList[index].path),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          // Back Button
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 0, 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFFFBF69), width: 4.0, strokeAlign: BorderSide.strokeAlignInside),
                ),
                child: IconButton(
                  onPressed: () => Navigator.pushNamed(context, "/food"), 
                  icon: Icon(Icons.arrow_back_rounded, color: Colors.black,),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 35, 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFF70C1B3), // Customize the border color if needed
                    width: 4.0,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.upload_file, color: Colors.black),
                  onPressed: () async {
                    // TODO: Add your upload action here
                    print("Upload button pressed");
                    File? imageFile = await pickImageFromGallery(); // or takePictureAndReturnFile()
                    if (imageFile != null) {
                      // Send to Gemini API
                      print("Image captured: ${imageFile.path}");
                      sendToGemini(imageFile);
                    } else {
                      print("No image selected or captured.");
                    }
                  },
                ),
              ),
            ),
          ),

          // Search Dish and Search by ingredients
          Stack(
            children: [

              // Find Recipe
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                left: isRecipeSelected ? size.width*0.41 : size.width*0.2,
                bottom: size.height*0.15,
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      isRecipeSelected = true;
                    });
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRecipeSelected ? Colors.white : Color(0x66FFFFFF),
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  ),
                  child: Text(
                    "Recipe",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.patrickHandSc(fontSize: 11, color: isRecipeSelected ? Colors.black : Color(0x80000000), fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
              ),

              // Find Recipe By ingredient
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                left: isRecipeSelected ? size.width*0.61 : size.width*0.4,
                bottom: size.height*0.15,
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      isRecipeSelected = false;
                    });
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRecipeSelected ? Color(0x66FFFFFF) : Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  ),
                  child: Text(
                    "Ingredients",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.patrickHandSc(fontSize: 11, color: isRecipeSelected ? Color(0x80000000) : Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}