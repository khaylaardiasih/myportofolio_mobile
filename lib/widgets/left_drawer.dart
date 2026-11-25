import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/experience_list.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

// Drawer navigasi samping untuk memudahkan perpindahan antar-halaman aplikasi
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca status autentikasi secara reaktif dari AuthState
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Drawer(
      child: ListView(
        children: [
          // Header drawer dengan visual tema portofolio
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF392529)),
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
                  isLoggedIn
                      ? 'Terautentikasi sebagai Admin Proyek'
                      : 'Explore personal projects and experiences!',
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
            leading: const Icon(Icons.home_outlined, color: Color(0xFF392529)),
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
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),

          // 2. Menu Navigasi ke Daftar Proyek (Tutorial 10)
          ListTile(
            leading: const Icon(
              Icons.folder_open_outlined,
              color: Color(0xFF392529),
            ),
            title: Text(
              'Lihat Proyek',
              style: GoogleFonts.jost(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF392529),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectListScreen(),
                ),
              );
            },
          ),

          // 3. Menu Navigasi ke Tambah Proyek (dilindungi auth guard)
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
            onTap: () async {
              // Pastikan user sudah login sebelum membuka halaman form proyek
              final authenticated = await ensureLoggedIn(context);
              if (!context.mounted) return;
              if (authenticated) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProjectFormPage(),
                  ),
                );
              }
            },
          ),

          // 4. Menu Navigasi ke Tambah Pengalaman (Tugas 8)
          ListTile(
            leading: const Icon(Icons.work_outline, color: Color(0xFF392529)),
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

          // 5. Menu Navigasi ke Daftar Pengalaman (Tugas 8)
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

          const Divider(),

          // 6. Tombol Login / Logout sesuai status sesi
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login, color: Color(0xFF392529)),
              title: Text(
                'Login',
                style: GoogleFonts.jost(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF392529),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: Text(
                'Logout',
                style: GoogleFonts.jost(
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent,
                ),
              ),
              onTap: () async {
                await context.read<AuthState>().logout();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Berhasil logout!',
                      style: GoogleFonts.jost(),
                    ),
                    backgroundColor: const Color(0xFF392529),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
