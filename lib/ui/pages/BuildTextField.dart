import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    Key key,
    @required this.width,
    @required this.controller,
    @required this.icon,
    @required this.hintText,
    @required this.textInputType,
  }) : super(key: key);

  final double width;
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: new ThemeData(
        primaryColor: Colors.green[600],
        primaryColorDark: Colors.greenAccent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Container(
          height: 60,
          width: width * 0.9,
          child: TextField(
            keyboardType: textInputType,
            style: GoogleFonts.dmSans(
              color: Colors.grey[700],
            ),
            decoration: InputDecoration(
                labelText: hintText,
                border: OutlineInputBorder(
                  gapPadding: 5,
                ),
                prefixIcon: Icon(icon)),
            controller: controller,
          ),
        ),
      ),
    );
  }
}
