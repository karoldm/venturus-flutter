import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  // Default color value
  Color color;

  // Uso de late para inicializar as propriedades posteriormente
  late ColorScheme colorScheme;
  late ColorScheme colorSchemeDark;
  late ThemeData customTheme;
  late ThemeData customThemeDark;

  CustomTheme({required this.color}) {
    colorScheme = ColorScheme.fromSeed(
      seedColor: color,
      brightness: Brightness.light,
      primary: Colors.orangeAccent,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    );

    colorSchemeDark = ColorScheme.fromSeed(
      seedColor: color,
      brightness: Brightness.dark,
      primary: Colors.orangeAccent,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    );

    customTheme = ThemeData(
      colorScheme: colorScheme,
      fontFamily: GoogleFonts.rubik().fontFamily,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: colorScheme.primary,
        titleTextStyle: GoogleFonts.rubik(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
        iconTheme: IconThemeData(color: colorScheme.onPrimary, size: 36),
      ),
      listTileTheme: ListTileThemeData(
        textColor: colorScheme.onSecondaryContainer,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.secondaryContainer,
        elevation: 5,
        shadowColor: Colors.transparent,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );

    customThemeDark = ThemeData(
      colorScheme: colorSchemeDark,
      listTileTheme: ListTileThemeData(
        textColor: colorSchemeDark.onSecondaryContainer,
      ),
      fontFamily: GoogleFonts.rubik().fontFamily,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: colorSchemeDark.onPrimary,
        titleTextStyle: GoogleFonts.rubik(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: colorSchemeDark.primary,
        ),
        iconTheme: IconThemeData(color: colorScheme.onPrimary, size: 36),
      ),
      cardTheme: CardThemeData(
        color: Colors.black54,
        elevation: 5,
        shadowColor: Colors.transparent,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
