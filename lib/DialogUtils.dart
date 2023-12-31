import 'package:flutter/material.dart';

class DialogUtils {
  static void showInfoDialog(BuildContext context, String title, String message, IconData icon, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Colors.purple[900], fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: TextStyle(color: Colors.purple[900], fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Icon(icon, color: color),
            ],
          ),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.purple[900]),
              ),
            ),
          ],
        );
      },
    );
  }
}
