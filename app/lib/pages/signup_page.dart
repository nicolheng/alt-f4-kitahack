import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tnc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _dobController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedGender;
  bool _isChecked = false;
  String? _errorMessage;

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dobController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = "Passwords do not match";
      });
      return;
    }
    if (!_isChecked) {
      setState(() {
        _errorMessage = "Please agree to the Terms and Conditions";
      });
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      await FirebaseAuth.instance.currentUser?.updateDisplayName(_usernameController.text.trim());
      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            title: const SizedBox(
              width: 200, // Explicit width
              child: Text("Sign-Up Successful!"),
            ),
            content: SizedBox(
              width: 200, // Explicit width
              child: const Text("Congratulations! Your account has been created successfully."),
            ),
            actions: [
              SizedBox(
                width: 80, // Constrain button width
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ),
            ],
          ),
        );
        if (mounted) {
          Navigator.pushReplacementNamed(context, "/login"); // Move navigation outside dialog
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = "Error: ${e.code} - ${e.message}";
      });
      print("FirebaseAuthException: ${e.code} - ${e.message}");
    } catch (e) {
      setState(() {
        _errorMessage = "Unexpected error: $e";
      });
      print("Unexpected error: $e");
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // Replace Stack with SingleChildScrollView directly
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: 16),
          constraints: BoxConstraints(
            minHeight: screenHeight, // Ensure it fills screen height
            maxWidth: 600,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: const Color(0xFF2EC4B6),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    AutoSizeText(
                      "Register as a User",
                      style: GoogleFonts.itim(
                        color: Colors.white,
                        fontSize: isLandscape ? screenWidth * 0.03 : screenWidth * 0.08,
                        fontWeight: isLandscape ? FontWeight.w500 : FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextField(
                      controller: _dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: _pickDate,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                      ),
                      items: ['Male', 'Female'].map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: AutoSizeText(gender),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Contact Number',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password Confirmation',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                      title: AutoSizeText.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.035,
                          ),
                          children: [
                            const TextSpan(text: "By providing your information, you acknowledge that you have read, understood and agreed to our "),
                            TextSpan(
                              text: "Terms and Conditions",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontSize: isLandscape ? screenWidth * 0.01 : screenWidth * 0.035,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TermsAndConditionsScreen()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    if (_errorMessage != null) ...[
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                    SizedBox(height: screenHeight * 0.01),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: AutoSizeText(
                          "Register",
                          style: GoogleFonts.inter(
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
    );
  }
}