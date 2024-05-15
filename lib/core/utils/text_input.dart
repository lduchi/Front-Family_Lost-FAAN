import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput(
      {super.key,
      required this.controller,
      required this.label,
      required this.icon,
      this.onChanges,
      this.isShow = false,
      this.isPassword = false ,
      });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Function()? onChanges;
  final bool isShow ;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        obscureText: isShow? !isPassword:false,
        controller:
            controller, // Asigna el controlador de texto al campo controller
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: isShow? IconButton(
            icon: Icon(
              isPassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () => onChanges!=null?  onChanges!():null,
          ):null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Color(0xFF707070)),
          ),
        ),
      ),
    );
  }
}