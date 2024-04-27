import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {

  /**
   * Font family: Roboto
   */
  static TextStyle get description => GoogleFonts.roboto(
        fontSize: 18.0,
        fontWeight: FontWeight.w100,
      );

  static TextStyle get navigation => GoogleFonts.roboto(
        fontSize: 14.0,
        fontWeight: FontWeight.w200,
      );

  /**
   * Font family: Poppins
   */
  static TextStyle get title => GoogleFonts.poppins(
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get primary => GoogleFonts.poppins(
        fontSize: 14.0,
        fontWeight: FontWeight.w100,
      );

  // static TextStyle get secondary => GoogleFonts.openSans(
  //       fontSize: 15.0,
  //       fontWeight: FontWeight.w500,
  //     );

  static TextStyle get button => GoogleFonts.poppins(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      );

  // static TextStyle get hint => GoogleFonts.openSans(
  //       fontSize: 15.0,
  //       fontWeight: FontWeight.w300,
  //     );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 12.0,
        fontWeight: FontWeight.w300,
      );

}
