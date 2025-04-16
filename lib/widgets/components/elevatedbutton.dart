import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final Widget text;
  const CustomElevatedButton({super.key, required this.text});

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(backgroundColor: WidgetStateColor.transparent),
      child: widget.text,
    );
  }
}
