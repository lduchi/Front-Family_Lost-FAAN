 
 import 'package:flutter/material.dart';

void showFieldError(BuildContext context,String fieldName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text('Error'),
            ],
          ),
          content: Text('Por favor, completa el campo "$fieldName". '),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }