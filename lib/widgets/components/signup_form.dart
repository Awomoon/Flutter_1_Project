import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_store/widgets/variables/validator.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const SignupForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isPrivate = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.usernameController,
            onSaved: (username) {},
            validator: usernameValidator.call,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF8F8F9),
              hintText: "Username",
              hintStyle: GoogleFonts.lexend(),
              prefixIcon: const Icon(CupertinoIcons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            style: GoogleFonts.lexend(),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: widget.emailController,
            onSaved: (email) {
              // Save email logic
            },
            validator: emailValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF8F8F9),
              hintText: "Email Address",
              hintStyle: GoogleFonts.lexend(),
              prefixIcon: const Icon(CupertinoIcons.mail),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            style: GoogleFonts.lexend(),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: widget.passwordController,
            onSaved: (pass) {
              // Save password logic
            },
            validator: passwordValidator.call,
            obscureText: isPrivate,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF8F8F9),
              hintText: "Password",
              hintStyle: GoogleFonts.lexend(),
              prefixIcon: const Icon(CupertinoIcons.padlock),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPrivate = !isPrivate;
                  });
                },
                icon: Icon(
                  isPrivate ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            style: GoogleFonts.lexend(),
          ),
        ],
      ),
    );
  }
}
