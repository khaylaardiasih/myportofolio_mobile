import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      debugShowCheckedModeBanner: false, // Menyembunyikan banner teks "DEBUG" di sudut kanan atas layar
      theme: ThemeData(
        // Tema utama bernuansa Pink Espresso
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF392529),
          primary: const Color(0xFF392529),
        ),
        // Latar belakang Blush Cream paling terang
        scaffoldBackgroundColor: const Color(0xFFF1DFD3),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}