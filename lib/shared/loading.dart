import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF04BFAD),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
