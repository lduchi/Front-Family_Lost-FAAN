import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.onChanges,
    this.isShow = false,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Function()? onChanges;
  final bool isShow;
  final bool isPassword;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        obscureText: isShow ? !isPassword : false,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: isShow
              ? IconButton(
                  icon: Icon(
                    isPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => onChanges != null ? onChanges!() : null,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Color(0xFF707070)),
          ),
        ),
      ),
    );
  }
}