import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malesin/commons/style.dart';

final myTextTheme = TextTheme(
  headline1: GoogleFonts.smooch(
    fontSize: 64,
    color: Colors.white,
  ),
  headline2: GoogleFonts.smooch(
    fontSize: 48,
    color: textPrimary,
  ),
  headline3: GoogleFonts.smooch(
    fontSize: 32,
    color: primaryColor,
  ),
  headline4: GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  ),
  subtitle1: GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  ),
  subtitle2: GoogleFonts.inter(
    fontSize: 10,
    color: textSecondary,
    fontWeight: FontWeight.w300,
  ),
  bodyText1: GoogleFonts.inter(
    fontSize: 12,
    color: textPrimary,
    fontWeight: FontWeight.w300,
  ),
  bodyText2: GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.normal,
  ),
  button: GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  ),
);
