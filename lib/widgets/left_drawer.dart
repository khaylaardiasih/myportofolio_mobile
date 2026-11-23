import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/experience_list.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

// Drawer navigasi samping untuk memudahkan perpindahan antar-halaman aplikasi
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Header drawer dengan visual tema portofolio
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF392529),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'My Portfolio',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFF1DFD3),
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: GoogleFonts.jost(
                    fontSize: 13,
                    color: const Color(0xFFD9A6A8),
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),

          // 1. Menu Navigasi ke Halaman Utama (Home)
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: Color(0xFF392529),
            ),
            title: Text(
              'Home',
              style: GoogleFonts.jost(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF392529),
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),

          // 2. Menu Navigasi ke Tambah Proyek (Tutorial 09)
          ListTile(
            leading: const Icon(
              Icons.post_add_outlined,
              color: Color(0xFF392529),
            ),
            title: Text(
              'Tambah Proyek',
              style: GoogleFonts.jost(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF392529),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectFormPage(),
                ),
              );
            },
          ),

          // 3. Menu Navigasi ke Tambah Pengalaman (Tugas 8)
          ListTile(
            leading: const Icon(
              Icons.work_outline,
              color: Color(0xFF392529),
            ),
            title: Text(
              'Tambah Pengalaman',
              style: GoogleFonts.jost(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF392529),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExperienceFormPage(),
                ),
              );
            },
          ),

          // kreativitas tugas 8: Menu navigasi drawer untuk membuka halaman daftar riwayat pengalaman
          ListTile(
            leading: const Icon(
              Icons.list_alt_outlined,
              color: Color(0xFF392529),
            ),
            title: Text(
              'Lihat Pengalaman',
              style: GoogleFonts.jost(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF392529),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExperienceListPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}