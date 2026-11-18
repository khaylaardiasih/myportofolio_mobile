import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

// drawer navigasi samping
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // bagian header drawer
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

          // navigasi ke home
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

          // navigasi ke form add project
          ListTile(
            leading: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFF392529),
            ),
            title: Text(
              'Add Project',
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
        ],
      ),
    );
  }
}
