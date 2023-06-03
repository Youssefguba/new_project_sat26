import 'package:flutter/material.dart';

typedef Validation = String? Function(String?)?;

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Validation validation; // Callback
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.icon,
    this.obscureText = false, // default value
    this.suffixIcon,
    this.controller,
    this.validation,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      // margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validation,
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
