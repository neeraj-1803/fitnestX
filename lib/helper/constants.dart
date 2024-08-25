import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const blueGradient = LinearGradient(
  colors: [
    Color.fromRGBO(157, 206, 255, 1.0),
    Color.fromRGBO(146, 164, 253, 1.0),
  ],
);

const purpleGradient = LinearGradient(
  colors: [
    Color.fromRGBO(197, 139, 242, 1.0),
    Color.fromRGBO(238, 164, 206, 1.0),
  ],
);

const lightBlueGradient = LinearGradient(colors: [
  Color.fromRGBO(146, 164, 253, 1.0),
  Color.fromRGBO(157, 206, 255, 1.0),
]);

const whiteColor = Colors.white;

const blueColor = Color.fromRGBO(157, 206, 255, 0.8);
const grayColor = Color.fromARGB(255, 225, 215, 218);
const grayColorFade = Color.fromRGBO(123, 111, 114, 0.5);
const purpleColor = Color.fromRGBO(146, 164, 253, 0.9);
const secondaryPurple = Color.fromRGBO(197, 139, 242, 1.0);

TextStyle font16pxLight = GoogleFonts.poppins(
  fontWeight: FontWeight.w300,
  fontSize: 16,
  color: grayColor,
);

TextStyle font16pxLightBlack = GoogleFonts.poppins(
  fontWeight: FontWeight.w300,
  fontSize: 16,
);

TextStyle font18pxLightBlack = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  fontSize: 18,
);

TextStyle font16pxLightPink = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: secondaryPurple,
);

TextStyle whiteBold = GoogleFonts.poppins(
  fontWeight: FontWeight.w800,
  fontSize: 16,
  color: Colors.white,
);

TextStyle blackBold = GoogleFonts.poppins(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontSize: 24,
);

TextStyle blackBold16px = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  fontSize: 16,
);

TextStyle greyReg = GoogleFonts.poppins(
  color: grayColor,
  fontWeight: FontWeight.w400,
  fontSize: 16,
);

TextStyle greyFont = GoogleFonts.poppins(
  color: grayColorFade,
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

TextStyle whiteFont = GoogleFonts.poppins(
  color: Colors.white,
  fontWeight: FontWeight.w400,
  fontSize: 14,
);
