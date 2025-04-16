import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final TextStyle _welcomeTextStyle = GoogleFonts.lexend(
    fontSize: 17,
    color: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/signup.jpg',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome To Moon-Store!',
                style: GoogleFonts.lexend(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Discover a world of style and convenience",
                  style: _welcomeTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  "at your fingertips.",
                  style: _welcomeTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  "Whether you're here to find the latest trends or",
                  style: _welcomeTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  "gifts that spark joy,",
                  style: _welcomeTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  "We've got something special just for you.",
                  style: _welcomeTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: const Color.fromRGBO(123, 97, 255, 1),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 32),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: const Text("Get Started."),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
