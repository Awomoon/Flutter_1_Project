import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_store/widgets/variables/validator.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isPrivate = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
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
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              hintText: "Email Address",
              prefixIcon: const Icon(CupertinoIcons.mail),
              hintStyle: GoogleFonts.lexend(),
            ),
            style: GoogleFonts.lexend(),
          ),
          const SizedBox(
            height: 16.0,
          ),
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
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
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
            ),
            style: GoogleFonts.lexend(),
          ),
        ],
      ),
    );
  }
}
