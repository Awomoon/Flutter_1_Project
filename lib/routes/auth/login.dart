import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moon_store/widgets/modals/hive_modal.dart';
import 'package:moon_store/widgets/components/login_form.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(
            'assets/signin.jpg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Welcome Back!',
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 16 / 2,
                ),
                Text(
                  "Log in with your data that you entered during your registration.",
                  style: GoogleFonts.lexend(),
                ),
                SizedBox(height: 16.0),
                LoginForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                Align(
                  child: TextButton(
                    style: ButtonStyle(
                      textStyle: WidgetStateProperty.all(
                          GoogleFonts.lexend(fontSize: 15)),
                    ),
                    child: const Text("Forgot password"),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 16 / 2,
                ),
                SizedBox(
                  width: double.infinity,
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                  
                        final email = _emailController.text;
                        final password = _passwordController.text;
                  
                        final userBox =
                            Hive.box<User>('userBox');
                        final user = userBox.get('user');
                  
                        if (user != null &&
                            user.email == email &&
                            user.password == password) {
                          Navigator.pushNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              duration: Duration(seconds: 3),
                              backgroundColor: Color.fromRGBO(123, 97, 255, 1),
                              content: Text('Invalid email or password.', style: GoogleFonts.lexend(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      "Log in",
                      style: GoogleFonts.lexend(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.lexend(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/signup");
                      },
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.lexend(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
