import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextInputType type;
  final bool isPassword ;
  final TextEditingController controller ;
  const CustomTextField({super.key,required this.isPassword , required this.hint, required this.type , required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
        ),
      ),
    );
  }
}
