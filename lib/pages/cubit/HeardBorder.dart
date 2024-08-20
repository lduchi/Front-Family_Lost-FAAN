import 'package:flutter/material.dart';

class HeartButton extends StatefulWidget {
  final VoidCallback onPressed;
  final int likes;
  final bool isLikedIt;

  const HeartButton({super.key, required this.likes, required this.isLikedIt, required this.onPressed}) ;

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
              Icons.favorite,
              color: widget.isLikedIt ? Colors.red : Colors.grey,
            ),
            SizedBox(width: 8),
            Text(
              '${widget.likes} ${widget.likes == 1 ? ' like':' likes'}',
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