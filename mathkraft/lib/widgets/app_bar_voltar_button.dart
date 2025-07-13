import 'package:flutter/material.dart';

class AppBarVoltarButton {
  AppBar criar (context, Color mainColor){
    return AppBar(
        backgroundColor: mainColor, 
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: mainColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      );
  }
}