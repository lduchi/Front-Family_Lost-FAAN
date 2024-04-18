import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle get title => GoogleFonts.openSans(
        fontSize: 30.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  static TextStyle get primary => GoogleFonts.openSans(
        fontSize: 25.0,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get secondary => GoogleFonts.openSans(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get button => GoogleFonts.openSans(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get hint => GoogleFonts.openSans(
        fontSize: 15.0,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get caption => GoogleFonts.openSans(
        fontSize: 12.0,
        fontWeight: FontWeight.w300,
      );
}
