import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/experience_list.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

// Helper navigasi untuk kartu menu beranda
void handleMenuTap(BuildContext context, ItemHomepage item) async {
  // Tombol Lihat Proyek (Tutorial 10)
  if (item.name == "Lihat Proyek") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProjectListScreen()),
    );
    return;
  }

  // Tombol Tambah Proyek dilindungi auth guard
  if (item.name == "Tambah Proyek") {
    final authenticated = await ensureLoggedIn(context);
    if (!context.mounted) return;
    if (authenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProjectFormPage()),
      );
    }
    return;
  }

  // Navigasi ke form tambah pengalaman (Tugas 8)
  if (item.name == "Tambah Pengalaman") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
    );
    return;
  }

  // Navigasi ke daftar pengalaman (Tugas 8)
  if (item.name == "Lihat Pengalaman") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExperienceListPage()),
    );
    return;
  }

  // Aksi Logout akun
  if (item.name == "Logout") {
    final authState = context.read<AuthState>();
    if (authState.isLoggedIn) {
      await authState.logout();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              "Berhasil logout dari akun!",
              style: GoogleFonts.jost(),
            ),
            backgroundColor: const Color(0xFF392529),
          ),
        );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("Anda belum login!", style: GoogleFonts.jost()),
            backgroundColor: const Color(0xFF855B60),
          ),
        );
    }
    return;
  }

  // Default SnackBar untuk tombol lainnya
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          "Kamu telah menekan tombol ${item.name}!",
          style: GoogleFonts.jost(),
        ),
        backgroundColor: const Color(0xFFB69A7D),
      ),
    );
}

// Widget kartu tombol menu statis
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(16),
      elevation: 2.5,
      child: InkWell(
        onTap: () => handleMenuTap(context, item),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: const Color(0xFFF1DFD3), size: 32.0),
                const SizedBox(height: 8.0),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jost(
                    color: const Color(0xFFF1DFD3),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Kartu tombol dengan animasi mikro pulse ketika ditekan
class PulseItemCard extends StatefulWidget {
  final ItemHomepage item;

  const PulseItemCard(this.item, {super.key});

  @override
  State<PulseItemCard> createState() => _PulseItemCardState();
}

class _PulseItemCardState extends State<PulseItemCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        handleMenuTap(context, widget.item);
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInOut,
        child: Material(
          color: widget.item.color,
          borderRadius: BorderRadius.circular(16),
          elevation: _isPressed ? 0.5 : 2.5,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.item.icon,
                    color: const Color(0xFFF1DFD3),
                    size: 32.0,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.item.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      color: const Color(0xFFF1DFD3),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
