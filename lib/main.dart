import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      debugShowCheckedModeBanner: false, // hilangin banner debug
      theme: ThemeData(
        // tema warna pink espresso
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF392529),
          primary: const Color(0xFF392529),
        ),
        scaffoldBackgroundColor: const Color(0xFFF1DFD3),
        useMaterial3: true,
        // styling font cormorant buat judul dan jost buat body
        textTheme: GoogleFonts.jostTextTheme().copyWith(
          displayLarge: GoogleFonts.cormorantGaramond(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          displayMedium: GoogleFonts.cormorantGaramond(
            fontWeight: FontWeight.w600,
          ),
          displaySmall: GoogleFonts.cormorantGaramond(
            fontWeight: FontWeight.w600,
          ),
          headlineLarge: GoogleFonts.cormorantGaramond(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
          headlineMedium: GoogleFonts.cormorantGaramond(
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: GoogleFonts.jost(),
          bodyMedium: GoogleFonts.jost(),
          bodySmall: GoogleFonts.jost(letterSpacing: 0.2),
          labelLarge: GoogleFonts.jost(fontWeight: FontWeight.w600),
        ),
      ),
      home: MyHomePage(),
    );
  }
}
