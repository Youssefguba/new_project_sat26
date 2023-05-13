import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;

  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.hint,
    required this.icon,
    this.obscureText = false, // default value
    this.suffixIcon,
    this.controller,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      // margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (text) {
          if(text!.isEmpty) {
            return 'Your field should not be empty!';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
