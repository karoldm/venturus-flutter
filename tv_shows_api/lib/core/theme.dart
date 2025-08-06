import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const color = Color.fromARGB(255, 158, 74, 255);

var colorScheme = ColorScheme.fromSeed(
  seedColor: color,
  brightness: Brightness.light,
);

var colorSchemeDark = ColorScheme.fromSeed(
  seedColor: color,
  brightness: Brightness.dark,
);

var customTheme = ThemeData(
  iconTheme: IconThemeData(color: colorScheme.onPrimary, size: 24),
  colorScheme: colorScheme,
  fontFamily: GoogleFonts.lato().fontFamily,
  appBarTheme: AppBarTheme(
    backgroundColor: colorScheme.primary,
    titleTextStyle: GoogleFonts.lobster(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: colorScheme.onPrimary,
    ),
  ),
  cardTheme: CardThemeData(
    color: colorScheme.secondaryContainer,
    shadowColor: colorScheme.onSurface,
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
);

var customThemeDark = ThemeData(
  iconTheme: IconThemeData(color: colorScheme.onPrimary, size: 24),
  colorScheme: colorSchemeDark,
  fontFamily: GoogleFonts.lato().fontFamily,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    toolbarHeight: 100,
    backgroundColor: colorSchemeDark.onPrimary,
    titleTextStyle: GoogleFonts.lobster(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: colorSchemeDark.primary,
    ),
  ),
  cardTheme: CardThemeData(
    color: colorSchemeDark.secondaryContainer,
    shadowColor: colorSchemeDark.onSurface,
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
);
