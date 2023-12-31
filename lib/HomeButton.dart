import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const HomeButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16.0),
        backgroundColor: Colors.purple[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40.0,
            color: Colors.white,
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
