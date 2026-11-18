import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

// widget kartu tombol menu
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
        onTap: () {
          // tampilin snackbar pas tombol ditekan
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

          // pindah ke form kalo tombol Tambah Proyek diklik
          if (item.name == "Tambah Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProjectFormPage(),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: const Color(0xFFF1DFD3),
                  size: 32.0,
                ),
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

// kartu tombol dengan animasi pulse pas ditekan
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
        _handleTap(context);
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

  void _handleTap(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            "Kamu telah menekan tombol ${widget.item.name}!",
            style: GoogleFonts.jost(),
          ),
          backgroundColor: const Color(0xFFB69A7D),
        ),
      );

    if (widget.item.name == "Tambah Proyek") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProjectFormPage(),
        ),
      );
    }
  }
}
