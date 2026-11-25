import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

// Helper route guard untuk memastikan pengguna sudah terautentikasi sebelum membuka layar tertentu
Future<bool> ensureLoggedIn(BuildContext context) async {
  // Jika sudah dalam keadaan login, izinkan akses secara langsung
  if (context.read<AuthState>().isLoggedIn) {
    return true;
  }

  // Jika belum login, alihkan ke LoginScreen dan tunggu hasil kembaliannya
  final loggedIn = await Navigator.push<bool>(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );

  return loggedIn ?? false;
}
