import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moon_store/widgets/modals/hive_modal.dart';
import 'package:moon_store/widgets/components/signup_form.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool termOfService = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/signup.jpg",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Let's get started!",
                    style: GoogleFonts.lexend(
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 16.0 / 2,
                  ),
                  Text(
                    "Please enter your valid data in order to create an account.",
                    style: GoogleFonts.lexend(),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SignupForm(
                    formKey: _formKey,
                    usernameController: _usernameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Checkbox(
                        value: termOfService,
                        onChanged: (value) {
                          setState(() {
                            termOfService = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "I agree with the",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                text: " Terms of service ",
                                style: const TextStyle(
                                  color: Color.fromRGBO(123, 97, 255, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(
                                text: "& privacy policy.",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0 * 2),
                  ElevatedButton(
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
  
                        final username = _usernameController.text;
                        final email = _emailController.text;
                        final password = _passwordController.text;
  
                        final user = User(
                          username: username,
                          email: email,
                          password: password,
                        );
  
                        final userBox = Hive.box<User>('userBox'); // Access as Box<User>
                        userBox.put('user', user);
  
                        Navigator.pushNamed(context, "/login");
                      }
                    },
                    child: const Text("Continue"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do you have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text("Log in"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}