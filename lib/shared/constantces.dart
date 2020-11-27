import 'package:flutter/material.dart';

var inputDecoration = InputDecoration(
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: Colors.red, width: 2.0)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: Colors.red, width: 2.0)),
  fillColor: Colors.white.withOpacity(0.2),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(width: 2.0, color: Colors.white),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(color: Color(0xFF04BFAD), width: 2.0),
  ),
);

const colors = [Color(0xFF04BFAD), Color(0xFF5259D9), Color(0xFF04BFAD)];

const colorblue = Color(0xFF2B1773);
