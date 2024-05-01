import 'package:flutter/material.dart';

class HeartButton extends StatefulWidget {
  final VoidCallback onPressed;

  const HeartButton({super.key, required this.onPressed}) ;

  @override
  _HeartButtonState createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
            SizedBox(width: 8),
            Text(
              '20 Likes',
              style: TextStyle(
                color: const Color.fromARGB(255, 87, 86, 86),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}