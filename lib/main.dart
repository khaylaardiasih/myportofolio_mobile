import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  // Inisialisasi ApiClient dan jalankan aplikasi utama
  runApp(MyApp(apiClient: ApiClient()));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.apiClient, super.key});

  final ApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    // MultiProvider menyuntikkan dependensi ApiClient dan AuthState ke seluruh widget tree
    return MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: apiClient),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState(apiClient)),
      ],
      child: MaterialApp(
        title: 'MyPortfolio',
        debugShowCheckedModeBanner: false, // Menghilangkan banner debug
        theme: ThemeData(
          // Tema warna pink espresso
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF392529),
            primary: const Color(0xFF392529),
          ),
          scaffoldBackgroundColor: const Color(0xFFF1DFD3),
          useMaterial3: true,
          // Styling font cormorant buat judul dan jost buat body
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
      ),
    );
  }
}
