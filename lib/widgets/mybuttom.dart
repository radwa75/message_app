// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
class mybutton extends StatelessWidget {
  mybutton({required this.color,required this.title,required this.onPressed});

  final Color color;
  final String title;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
          elevation: 5,
          color: color,
          borderRadius: BorderRadius.circular(50),
          child: MaterialButton(
            onPressed: onPressed,
            minWidth: 250,
            height: 45,
            child: Text(title,
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w900,
                    fontSize: 20)),
          )),
    );
  }
}
