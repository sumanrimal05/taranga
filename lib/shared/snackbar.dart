import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
    content: Container(
      alignment: Alignment.center,
      height: 30,
      child: Text(
        message,
        style: TextStyle(fontSize: 20),
      ),
    ),
    backgroundColor: color,
    duration: Duration(seconds: 3),
    // shape: StadiumBorder(),
    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
  );

  // Scaffold.of(context)
  //   ..hideCurrentSnackBar()
  //   ..showSnackBar(snackBar);

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
