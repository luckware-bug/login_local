import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const PasswordTextField({
    Key? key,
    required this.controller,
    this.labelText = "Contraseña",
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility))),
    );
  }
}
