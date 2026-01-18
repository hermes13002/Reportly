import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// reportly app theme configuration
class AppTheme {
  // colors - purple theme
  static const primaryColor = Color(0xFF8B5CF6); // vivid violet
  static const primaryDark = Color(0xFF7C3AED);
  static const primaryLight = Color(0xFFA78BFA);
  static const accentColor = Color(0xFF9F7AEA);

  static const backgroundDark = Color(0xFF131022); // deep space purple
  static const surfaceDark = Color(0xFF1F1B2E); // dark purple surface
  static const cardDark = Color(0xFF1F1B2E);
  static const dividerDark = Color(0xFF2D2A42);

  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB3B3B3);
  static const textHint = Color(0xFF6B6B80);

  static const successColor = Color(0xFF4CAF50);
  static const warningColor = Color(0xFFFFC107);
  static const errorColor = Color(0xFFEF4444);

  // space grotesk text style helper
  static TextStyle _font({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = textPrimary,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // dark theme
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
    textTheme: GoogleFonts.spaceGroteskTextTheme(ThemeData.dark().textTheme),
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: accentColor,
      onSecondary: Colors.white,
      surface: surfaceDark,
      onSurface: textPrimary,
      error: errorColor,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDark,
      foregroundColor: textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: _font(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      iconTheme: const IconThemeData(color: textPrimary),
    ),
    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withOpacity(0.05)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF252136),
      labelStyle: _font(color: textSecondary),
      hintStyle: _font(color: textHint),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: _font(fontSize: 16, fontWeight: FontWeight.w600),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(color: primaryColor),
        textStyle: _font(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: _font(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: CircleBorder(),
    ),
    dividerTheme: const DividerThemeData(
      color: dividerDark,
      thickness: 1,
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      iconColor: textSecondary,
      titleTextStyle: _font(
        fontSize: 16,
        color: textPrimary,
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: _font(fontSize: 14, color: textSecondary),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: cardDark,
      contentTextStyle: _font(color: textPrimary),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryColor,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF252136),
      labelStyle: _font(color: textPrimary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide.none,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: _font(color: textPrimary),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: surfaceDark,
      titleTextStyle: _font(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      contentTextStyle: _font(fontSize: 14, color: textSecondary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelStyle: _font(fontSize: 14, fontWeight: FontWeight.w600),
      unselectedLabelStyle: _font(fontSize: 14),
      indicatorColor: primaryColor,
      dividerColor: dividerDark,
    ),
    iconTheme: const IconThemeData(
      color: textSecondary,
    ),
  );

  // light theme
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
    textTheme: GoogleFonts.spaceGroteskTextTheme(ThemeData.light().textTheme),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: accentColor,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xFF1F1B2E), // Dark text on light surface
      error: errorColor,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFFF3F4F6), // Light gray bg
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFF3F4F6),
      foregroundColor: const Color(0xFF1F1B2E),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: _font(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1F1B2E),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF1F1B2E)),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black.withOpacity(0.05)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFFFFFFF),
      labelStyle: _font(color: textHint),
      hintStyle: _font(color: textHint),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: _font(fontSize: 16, fontWeight: FontWeight.w600),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(color: primaryColor),
        textStyle: _font(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: _font(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: CircleBorder(),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey[200],
      thickness: 1,
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      iconColor: textHint,
      titleTextStyle: _font(
        fontSize: 16,
        color: const Color(0xFF1F1B2E),
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: _font(fontSize: 14, color: textHint),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF1F1B2E),
      contentTextStyle: _font(color: Colors.white),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: textHint,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey[100],
      labelStyle: _font(color: const Color(0xFF1F1B2E)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide.none,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: _font(color: const Color(0xFF1F1B2E)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      titleTextStyle: _font(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1F1B2E),
      ),
      contentTextStyle: _font(fontSize: 14, color: textHint),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelStyle: _font(fontSize: 14, fontWeight: FontWeight.w600),
      unselectedLabelStyle: _font(fontSize: 14),
      indicatorColor: primaryColor,
      dividerColor: Colors.grey[200],
    ),
    iconTheme: const IconThemeData(
      color: textHint,
    ),
  );
}
