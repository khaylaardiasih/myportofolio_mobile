import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/menu.dart';

/// Kreativitas Tugas 7: PulseItemCard — Kartu tombol interaktif dengan animasi scale (pulse).
/// Memberikan umpan balik visual yang halus saat tombol ditekan.
class PulseItemCard extends StatefulWidget {
  final ItemHomepage item;

  const PulseItemCard(this.item, {super.key});

  @override
  State<PulseItemCard> createState() => _PulseItemCardState();
}

class _PulseItemCardState extends State<PulseItemCard> {
  // State untuk melacak apakah kartu sedang ditekan
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Saat kartu mulai ditekan, kecilkan ukuran kartu ke 92%
      onTapDown: (_) => setState(() => _isPressed = true),
      // Saat jari diangkat, kembalikan ukuran dan munculkan SnackBar
      onTapUp: (_) {
        setState(() => _isPressed = false);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("Kamu telah menekan tombol ${widget.item.name}!"),
              backgroundColor: const Color(0xFFB69A7D), // Warm Tan
            ),
          );
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
                    color: const Color(0xFFF1DFD3), // Blush Cream
                    size: 32.0,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFF1DFD3), // Blush Cream
                      fontWeight: FontWeight.w600,
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